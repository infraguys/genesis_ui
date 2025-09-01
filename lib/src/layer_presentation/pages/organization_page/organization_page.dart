import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/params/organizations/update_organization_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/organization_page/widgets/delete_organization_elevated_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _OrganizationView extends StatefulWidget {
  const _OrganizationView({required this.organization});

  final Organization organization;

  @override
  State<_OrganizationView> createState() => _OrganizationViewState();
}

class _OrganizationViewState extends State<_OrganizationView> {
  final _formKey = GlobalKey<FormState>();

  late _ControllersManager _controllersManager;
  late final OrganizationBloc _organizationBloc;

  @override
  void initState() {
    _organizationBloc = context.read<OrganizationBloc>();
    _controllersManager = _ControllersManager(widget.organization);
    super.initState();
  }

  @override
  void dispose() {
    _controllersManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrganizationBloc, OrganizationState>(
      listenWhen: (_, current) => switch (current) {
        OrganizationUpdatedState() || OrganizationDeletedState() || OrganizationFailureState() => true,
        _ => false,
      },
      listener: (context, state) {
        final navigator = GoRouter.of(context);
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case OrganizationUpdatedState(:final organization):
            messenger.showSnackBar(AppSnackBar.success(context.$.msgOrganizationUpdated(organization.name)));
            context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());

          case OrganizationDeletedState(:final organization):
            messenger.showSnackBar(AppSnackBar.success(context.$.msgOrganizationDeleted(organization.name)));
            context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
            navigator.pop();

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
                BreadcrumbItem(text: widget.organization.name),
              ],
            ),
            ButtonsBar(
              children: [
                DeleteOrganizationElevatedButton(organization: widget.organization),
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
        ),
      ),
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _organizationBloc.add(
        OrganizationEvent.update(
          UpdateOrganizationParams(
            uuid: widget.organization.uuid,
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

class OrganizationPage extends StatelessWidget {
  const OrganizationPage({required this.organization, super.key});

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrganizationBloc(context.read<IOrganizationsRepository>()),
      child: _OrganizationView(organization: organization),
    );
  }
}
