import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/params/update_organization_params.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

part './widgets/delete_organization_btn.dart';

part './widgets/save_organization_btn.dart';

class _OrganizationDetailsView extends StatefulWidget {
  const _OrganizationDetailsView({required this.id});

  final OrganizationID id;

  @override
  State<_OrganizationDetailsView> createState() => _OrganizationDetailsViewState();
}

class _OrganizationDetailsViewState extends State<_OrganizationDetailsView> {
  final _formKey = GlobalKey<FormState>();

  late final OrganizationBloc _organizationBloc;
  late final OrganizationsBloc _organizationsBloc;

  late String _name;
  late String? _description;

  @override
  void initState() {
    _organizationBloc = context.read<OrganizationBloc>();
    _organizationsBloc = context.read<OrganizationsBloc>();
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
          case OrganizationLoadedState(:final organization):
            _name = organization.name;
            _description = organization.description;

          case OrganizationUpdatedState(:final organization):
            messenger.showSnackBar(AppSnackBar.success(context.$.msgOrganizationUpdated(organization.name)));
            _organizationsBloc.add(OrganizationsEvent.getOrganizations());

          case OrganizationDeletedState(:final organization):
            messenger.showSnackBar(AppSnackBar.success(context.$.msgOrganizationDeleted(organization.name)));
            _organizationsBloc.add(OrganizationsEvent.getOrganizations());
            navigator.pop();

          case OrganizationPermissionFailureState(:final message):
          case OrganizationFailureState(:final message):
            messenger.showSnackBar(AppSnackBar.failure(context.$.msgPermissionDenied(message)));
          default:
        }
      },
      child: Scaffold(
        body: BlocBuilder<OrganizationBloc, OrganizationState>(
          buildWhen: (previous, current) => current is OrganizationLoadingState || current is OrganizationLoadedState,
          builder: (context, state) {
            if (state is! OrganizationLoadedState) {
              return AppProgressIndicator();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                Breadcrumbs(
                  items: [
                    BreadcrumbItem(text: context.$.organizations),
                    BreadcrumbItem(text: state.organization.name),
                  ],
                ),
                ButtonsBar(
                  children: [
                    _DeleteOrganizationButton(organization: state.organization),
                    _SaveOrganizationButton(onPressed: save),
                  ],
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.4,
                            child: AppTextFormInput(
                              initialValue: _name,
                              helperText: context.$.projectName,
                              onSaved: (newValue) => _name = newValue!,
                              validator: (value) => switch (value) {
                                _ when value!.isEmpty => context.$.requiredField,
                                _ => null,
                              },
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.4,
                            child: AppTextFormInput(
                              initialValue: _description,
                              helperText: context.$.description,
                              onSaved: (newValue) => _description = newValue!,
                              minLines: 3,
                              maxLines: null,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _organizationBloc.add(
        OrganizationEvent.update(
          UpdateOrganizationParams(
            id: widget.id,
            name: _name,
            description: _description,
          ),
        ),
      );
    }
  }
}

class OrganizationDetailsPage extends StatelessWidget {
  const OrganizationDetailsPage({required this.id, super.key});

  final OrganizationID id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrganizationBloc(
        context.read<IOrganizationsRepository>(),
      )..add(OrganizationEvent.get(id)),
      child: _OrganizationDetailsView(id: id),
    );
  }
}
