import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_selection_bloc/organizations_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/project_bloc/project_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/widgets/organizations_table.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/widgets/roles_table.dart';
import 'package:genesis/src/layer_presentation/pages/users/users_page/widgets/users_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({required this.project, super.key});

  final Project project;

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final _formKey = GlobalKey<FormState>();

  late _ControllersManager _controllersManager;

  @override
  void initState() {
    context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
    context.read<UsersBloc>().add(UsersEvent.getUsers());
    context.read<RolesBloc>().add(RolesEvent.getRoles());
    _controllersManager = _ControllersManager(widget.project);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
      listenWhen: (_, current) => switch (current) {
        ProjectCreatedState() => true,
        _ => false,
      },
      listener: (context, state) {
        final navigator = GoRouter.of(context);
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        var snack = AppSnackBar.success(context.$.success);

        switch (state) {
          case ProjectCreatedState():
            context.read<ProjectsBloc>().add(ProjectsEvent.getProjects());
          // case UserFailureState(:final message):
          // snack = AppSnackBar.failure(message);
          default:
        }
        // todo: не всегда возвращать true
        scaffoldMessenger.showSnackBar(snack).closed.then((_) => navigator.pop(true));
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              Breadcrumbs(
                items: [
                  BreadcrumbItem(text: context.$.projects),
                  BreadcrumbItem(text: context.$.create),
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
                    if (state is! OrganizationsLoadedState) {
                      return AppProgressIndicator();
                    }
                    return OrganizationsTable(organizations: state.organizations);
                  },
                ),
              ),
              Text(context.$.users, style: TextStyle(color: Colors.white54, fontSize: 24)),
              SizedBox(
                height: 405,
                child: BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    if (state is! UsersLoadedState) {
                      return AppProgressIndicator();
                    }
                    return UsersTable(users: state.users);
                  },
                ),
              ),
              Text(context.$.roles, style: TextStyle(color: Colors.white54, fontSize: 24)),
              SizedBox(
                height: 405,
                child: BlocBuilder<RolesBloc, RolesState>(
                  builder: (context, state) {
                    if (state is! RolesLoaded) {
                      return AppProgressIndicator();
                    }
                    return RolesTable(roles: state.roles);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ProjectBloc>().add(
        ProjectEvent.create(
          name: _controllersManager.nameController.text,
          description: _controllersManager.descriptionController.text,
          organizationUuid: context.read<OrganizationsSelectionBloc>().state.first.uuid,
          userUuid: context.read<UsersSelectionBloc>().state.first.uuid,
          roleUuid: context.read<RolesSelectionBloc>().state.map((role) => role.uuid).toList(),
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
