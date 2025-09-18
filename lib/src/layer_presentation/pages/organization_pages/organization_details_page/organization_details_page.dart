import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/params/organizations/update_organization_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/confirmation_dialog.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

part './widgets/delete_organization_btn.dart';

class _OrganizationDetailsView extends StatefulWidget {
  const _OrganizationDetailsView({required this.uuid});

  final OrganizationUUID uuid;

  @override
  State<_OrganizationDetailsView> createState() => _OrganizationDetailsViewState();
}

class _OrganizationDetailsViewState extends State<_OrganizationDetailsView> {
  final _formKey = GlobalKey<FormState>();

  late _ControllersManager _controllersManager;
  late final OrganizationBloc _organizationBloc;
  late final OrganizationsBloc _organizationsBloc;

  @override
  void initState() {
    _organizationBloc = context.read<OrganizationBloc>();
    _organizationsBloc = context.read<OrganizationsBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _controllersManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OrganizationBloc, OrganizationState>(
        listenWhen: (_, current) {
          switch (current) {
            case OrganizationUpdatedState():
            case OrganizationDeletedState():
            case OrganizationLoadedState():
            case OrganizationFailureState():
              return true;
            default:
              return false;
          }
        },
        listener: (context, state) {
          final navigator = GoRouter.of(context);
          final messenger = ScaffoldMessenger.of(context);

          switch (state) {
            case OrganizationLoadedState(:final organization):
              _controllersManager = _ControllersManager(organization);

            case OrganizationUpdatedState(:final organization):
              _organizationBloc.add(OrganizationEvent.get(widget.uuid));
              messenger.showSnackBar(AppSnackBar.success(context.$.msgOrganizationUpdated(organization.name)));
              _organizationsBloc.add(OrganizationsEvent.getOrganizations());

            case OrganizationDeletedState(:final organization):
              messenger.showSnackBar(AppSnackBar.success(context.$.msgOrganizationDeleted(organization.name)));
              _organizationsBloc.add(OrganizationsEvent.getOrganizations());
              navigator.pop();

            case OrganizationFailureState(:final message):
              messenger.showSnackBar(AppSnackBar.failure(message));
            default:
          }
        },
        builder: (context, state) {
          if (state is! OrganizationLoadedState) {
            return AppProgressIndicator();
          }
          final organization = state.organization;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              Breadcrumbs(
                items: [
                  BreadcrumbItem(text: context.$.organizations),
                  BreadcrumbItem(text: organization.name),
                ],
              ),
              ButtonsBar(
                children: [
                  _DeleteOrganizationButton(organization: organization),
                  SaveIconButton(onPressed: save),
                ],
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.4,
                          child: AppTextInput(
                            controller: _controllersManager.nameController,
                            hintText: context.$.name,
                            validator: (value) => switch (value) {
                              _ when value!.isEmpty => context.$.requiredField,
                              _ => null,
                            },
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.4,
                          child: AppTextInput.multiLine(
                            controller: _controllersManager.descriptionController,
                            hintText: context.$.description,
                            minLines: 3,
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
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _organizationBloc.add(
        OrganizationEvent.update(
          UpdateOrganizationParams(
            uuid: widget.uuid,
            name: _controllersManager.nameController.text,
            description: _controllersManager.descriptionController.text,
          ),
        ),
      );
    }
  }
}

class _ControllersManager extends FormControllersManager {
  _ControllersManager(Organization organization)
    : nameController = TextEditingController(text: organization.name),
      descriptionController = TextEditingController(text: organization.description);

  final TextEditingController nameController;
  final TextEditingController descriptionController;

  @override
  List<TextEditingController> get all => [nameController, descriptionController];
}

class OrganizationDetailsPage extends StatelessWidget {
  const OrganizationDetailsPage({required this.uuid, super.key});

  final OrganizationUUID uuid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrganizationBloc(
        context.read<IOrganizationsRepository>(),
      )..add(OrganizationEvent.get(uuid)),
      child: _OrganizationDetailsView(uuid: uuid),
    );
  }
}
