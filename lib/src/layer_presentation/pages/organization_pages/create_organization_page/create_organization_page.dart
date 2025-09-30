import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/params/organizations/create_organization_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _CreateOrganizationView extends StatefulWidget {
  const _CreateOrganizationView();

  @override
  State<_CreateOrganizationView> createState() => _CreateOrganizationViewState();
}

class _CreateOrganizationViewState extends State<_CreateOrganizationView> {
  final _formKey = GlobalKey<FormState>();

  late final OrganizationBloc _organizationBloc;

  var _name = '';
  var _description = '';

  @override
  void initState() {
    _organizationBloc = context.read<OrganizationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrganizationBloc, OrganizationState>(
      listenWhen: (_, current) => switch (current) {
        _ when current is! OrganizationLoadingState => true,
        _ => false,
      },
      listener: (context, state) {
        final navigator = GoRouter.of(context);
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case OrganizationCreatedState():
            context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
            messenger.showSnackBar(AppSnackBar.success(context.$.success));
            navigator.pop();

          case OrganizationPermissionFailureState(:final message):
          case OrganizationFailureState(:final message):
            messenger.showSnackBar(AppSnackBar.failure(message));
          default:
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Breadcrumbs(
              items: [
                BreadcrumbItem(text: context.$.organizations),
                BreadcrumbItem(text: context.$.create),
              ],
            ),
            ButtonsBar(
              children: [
                SaveIconButton(onPressed: save),
              ],
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24,
                      children: [
                        TextFormField(
                          initialValue: _name,
                          decoration: InputDecoration(
                            hintText: context.$.name,
                          ),
                          onSaved: (newValue) => _name = newValue!,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        TextFormField(
                          initialValue: _description,
                          decoration: InputDecoration(
                            hintText: context.$.description,
                          ),
                          onSaved: (newValue) => _description = newValue!,
                          minLines: 3,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _organizationBloc.add(
        OrganizationEvent.create(CreateOrganizationParams(name: _name, description: _description,)),
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
