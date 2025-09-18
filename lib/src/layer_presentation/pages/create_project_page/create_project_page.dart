import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_selection_bloc/organizations_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/project_bloc/project_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/organization_pages/organization_list_page/widgets/organizations_table.dart';
import 'package:genesis/src/layer_presentation/pages/role_pages/role_list_page/widgets/roles_table.dart';
import 'package:genesis/src/layer_presentation/pages/user_pages/users_list_page/widgets/users_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _CreateProjectView extends StatefulWidget {
  const _CreateProjectView();

  @override
  State<_CreateProjectView> createState() => _CreateProjectViewState();
}

class _CreateProjectViewState extends State<_CreateProjectView> {
  final _formKey = GlobalKey<FormState>();

  late _ControllersManager _controllersManager;

  @override
  void initState() {
    context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
    context.read<UsersBloc>().add(UsersEvent.getUsers());
    _controllersManager = _ControllersManager();
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
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case ProjectCreatedState():
            context.read<ProjectsBloc>().add(ProjectsEvent.getProjects());
            messenger.showSnackBar(AppSnackBar.success(context.$.success));
            navigator.pop();
          case ProjectFailureState(:final message):
            messenger.showSnackBar(AppSnackBar.failure(message));
          default:
        }
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
                    return OrganizationsTable(organizations: state.organizations, allowMultiSelect: false);
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
                    return UsersTable(users: state.users, allowMultiSelect: false);
                  },
                ),
              ),
              Text(context.$.roles, style: TextStyle(color: Colors.white54, fontSize: 24)),
              SizedBox(
                height: 405,
                child: BlocBuilder<RolesBloc, RolesState>(
                  builder: (context, state) {
                    if (state is! RolesLoadedState) {
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
          organizationUUID: context.read<OrganizationsSelectionBloc>().state.first.uuid,
          userUUID: context.read<UsersSelectionBloc>().state.firstOrNull?.uuid,
          roles: context.read<RolesSelectionBloc>().state,
        ),
      );
    }
  }
}

class _ControllersManager extends FormControllersManager {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  List<TextEditingController> get all => [nameController, descriptionController];
}

class CreateProjectPage extends StatelessWidget {
  const CreateProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProjectBloc(
            projectsRepository: context.read<IProjectsRepository>(),
            roleBindingsRepository: context.read<IRoleBindingsRepository>(),
          ),
        ),
        BlocProvider(
          create: (_) => OrganizationsSelectionBloc(),
        ),
        BlocProvider(
          create: (_) => UsersSelectionBloc(),
        ),
        BlocProvider(
          create: (_) => RolesSelectionBloc(),
        ),
      ],
      child: _CreateProjectView(),
    );
  }
}
