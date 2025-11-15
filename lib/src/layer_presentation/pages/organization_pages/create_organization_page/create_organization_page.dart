import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/organizations/domain/params/create_organization_params.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/general_dialog_layout.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _CreateOrganizationView extends StatefulWidget {
  const _CreateOrganizationView();

  @override
  State<_CreateOrganizationView> createState() => _CreateOrganizationViewState();
}

class _CreateOrganizationViewState extends State<_CreateOrganizationView> {
  final _formKey = GlobalKey<FormState>();

  late final OrganizationBloc _organizationBloc;

  var _orgName = '';
  var _description = '';

  @override
  void initState() {
    _organizationBloc = context.read<OrganizationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const gapWidth = 16.0;

    return BlocListener<OrganizationBloc, OrganizationState>(
      listenWhen: (_, current) => switch (current) {
        _ when current is! OrganizationLoadingState => true,
        _ => false,
      },
      listener: (context, state) {
        final navigator = GoRouter.of(context);
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case OrganizationCreatedState(:final organization):
            context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
            messenger.showSnackBar(AppSnackBar.success(context.$.msgOrganizationCreated(organization.name)));
            navigator.pop();

          case OrganizationPermissionFailureState(:final message):
            messenger.showSnackBar(AppSnackBar.failure(context.$.msgPermissionDenied(message)));
          case OrganizationFailureState(:final message):
            messenger.showSnackBar(AppSnackBar.failure(message));
          default:
        }
      },
      child: GeneralDialogLayout(
        constraints: BoxConstraints(maxWidth: 900),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: gapWidth,
            children: [
              Row(
                children: [
                  Icon(Icons.business_sharp, size: 100),
                  SizedBox(width: 32),
                  SizedBox(
                    width: 500,
                    child: AppTextFormInput(
                      initialValue: _orgName,
                      helperText: context.$.orgNameHelperText,
                      onSaved: (newValue) => _orgName = newValue!,
                      validator: (value) => switch (value) {
                        _ when value!.isEmpty => context.$.requiredField,
                        _ => null,
                      },
                    ),
                  ),
                ],
              ),
              Divider(color: Palette.color1B1B1D),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columnWidth = (constraints.maxWidth - 3 * gapWidth) / 4;
                  return SizedBox(
                    width: constraints.maxWidth,
                    child: AppTextFormInput.description(
                      initialValue: _description,
                      helperText: context.$.description,
                      onSaved: (newValue) => _description = newValue!,
                    ),
                  );
                },
              ),
              Row(
                children: [
                  Spacer(),
                  SaveIconButton(onPressed: save),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _organizationBloc.add(
        .create(
          CreateOrganizationParams(name: _orgName, description: _description),
        ),
      );
    }
  }
}

class CreateOrganizationPage extends StatelessWidget {
  const CreateOrganizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrganizationBloc(context.read<IOrganizationsRepository>()),
      child: const _CreateOrganizationView(),
    );
  }
}
