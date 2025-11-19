import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/params/update_organization_params.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/delete_elevated_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/form_card.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/id_widget.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/metadata_table.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/organization_status_widget.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/page_layout.dart';
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

  late String _orgName;
  late String? _description;

  @override
  void initState() {
    _organizationBloc = context.read<OrganizationBloc>();
    _organizationsBloc = context.read<OrganizationsBloc>();
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
          case OrganizationLoadedState(:final organization):
            _orgName = organization.name;
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
      child: BlocBuilder<OrganizationBloc, OrganizationState>(
        buildWhen: (previous, current) => current is OrganizationLoadingState || current is OrganizationLoadedState,
        builder: (context, state) {
          if (state is! OrganizationLoadedState) {
            return AppProgressIndicator();
          }
          final OrganizationLoadedState(:organization) = state;
          return Form(
            child: PageLayout(
              breadcrumbs: [
                BreadcrumbItem(text: context.$.organizations),
                BreadcrumbItem(text: organization.name),
              ],
              buttons: [
                _DeleteOrganizationButton(organization: organization),
                _SaveOrganizationButton(onPressed: save),
              ],
              child: Column(
                spacing: gapWidth,
                children: [
                  FormCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.business_sharp, size: 100),
                        SizedBox(width: 32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: gapWidth,
                          children: [
                            IdWidget(id: organization.id.value),
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
                        Spacer(),
                        MetadataTable(
                          statusWidget: OrganizationStatusWidget(status: organization.status),
                          createdAt: organization.createdAt,
                          updatedAt: organization.updatedAt,
                        ),
                      ],
                    ),
                  ),
                  FormCard(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          children: [
                            SizedBox(
                              width: constraints.maxWidth,
                              child: AppTextFormInput.description(
                                initialValue: _description,
                                helperText: context.$.description,
                                onSaved: (newValue) => _description = newValue!,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
            name: _orgName,
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
