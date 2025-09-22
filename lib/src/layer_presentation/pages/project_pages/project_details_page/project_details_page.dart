import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_selection_bloc/organizations_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/project_bloc/project_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/organization_pages/organization_list_page/widgets/organizations_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _ProjectDetailsView extends StatefulWidget {
  const _ProjectDetailsView({required this.uuid});

  final ProjectUUID uuid;

  @override
  State<_ProjectDetailsView> createState() => _ProjectDetailsViewState();
}

class _ProjectDetailsViewState extends State<_ProjectDetailsView> {
  final _formKey = GlobalKey<FormState>();

  late _ControllersManager _controllersManager;

  @override
  void initState() {
    context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
    context.read<UsersBloc>().add(UsersEvent.getUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProjectBloc, ProjectState>(
        listenWhen: (_, current) => switch (current) {
          ProjectCreatedState() || ProjectUpdatedState() || ProjectLoadedState() => true,
          _ => false,
        },
        listener: (context, state) {
          final navigator = GoRouter.of(context);
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          var snack = AppSnackBar.success(context.$.success);

          switch (state) {
            case ProjectLoadedState(:final project):
              _controllersManager = _ControllersManager(project);
            case ProjectUpdatedState():
              context.read<ProjectsBloc>().add(ProjectsEvent.getProjects());
              scaffoldMessenger.showSnackBar(snack).closed.then((_) => navigator.pop(true));
            case ProjectFailureState(:final message):
              scaffoldMessenger.showSnackBar(AppSnackBar.failure(message));
            default:
          }
        },
        builder: (context, state) {
          if (state is! ProjectLoadedState) {
            return AppProgressIndicator();
          }
          final project = state.project;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                Breadcrumbs(
                  items: [
                    BreadcrumbItem(text: context.$.projects),
                    BreadcrumbItem(text: project.name),
                  ],
                ),
                ButtonsBar(
                  children: [
                    SaveIconButton(onPressed: () => save(context)),
                  ],
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Form(
                      key: _formKey,
                      child: Row(
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
                            child: AppTextInput(
                              controller: _controllersManager.descriptionController,
                              hintText: context.$.description,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Text(context.$.organizations, style: TextStyle(color: Colors.white54, fontSize: 24)),
                SizedBox(
                  height: 405,
                  child: BlocBuilder<OrganizationsBloc, OrganizationsState>(
                    builder: (context, state) {
                      if (state is OrganizationsLoadedState) {
                        context.read<OrganizationsSelectionBloc>().add(
                          OrganizationsSelectionEvent.setCheckedFromResponse(
                            project,
                            organizations: state.organizations,
                          ),
                        );
                        return OrganizationsTable(organizations: state.organizations, allowMultiSelect: false);
                      }
                      return AppProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ProjectBloc>().add(
        ProjectEvent.update(
          uuid: widget.uuid,
          name: _controllersManager.nameController.text,
          description: _controllersManager.descriptionController.text,
          organizationUUID: context.read<OrganizationsSelectionBloc>().state.first.uuid,
        ),
      );
    }
  }
}

class _ControllersManager extends FormControllersManager {
  _ControllersManager(Project project)
    : nameController = TextEditingController(text: project.name),
      descriptionController = TextEditingController(text: project.description);

  final TextEditingController nameController;
  final TextEditingController descriptionController;

  @override
  List<TextEditingController> get all => [nameController, descriptionController];
}

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({required this.uuid, super.key});

  final ProjectUUID uuid;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProjectBloc(
            projectsRepository: context.read<IProjectsRepository>(),
            roleBindingsRepository: context.read<IRoleBindingsRepository>(),
          )..add(ProjectEvent.getProject(uuid)),
        ),
        BlocProvider(
          create: (_) => OrganizationsSelectionBloc(),
        ),
      ],
      child: _ProjectDetailsView(uuid: uuid),
    );
  }
}
