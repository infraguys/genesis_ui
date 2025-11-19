import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_selection_bloc/organizations_selection_bloc.dart';
import 'package:genesis/src/features/projects/presentation/blocs/project_bloc/project_bloc.dart';
import 'package:genesis/src/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/features/roles/presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/features/roles/presentation/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/features/users/presentation/blocs/user_selection_cubit/users_selection_bloc.dart';
import 'package:genesis/src/features/organizations/presentation/pages/organization_list_page/widgets/organizations_table.dart';
import 'package:genesis/src/features/roles/presentation/pages/role_list_page/widgets/roles_table.dart';
import 'package:genesis/src/features/users/presentation/pages/user_list_page/widgets/users_table.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _CreateProjectView extends StatefulWidget {
  const _CreateProjectView();

  @override
  State<_CreateProjectView> createState() => _CreateProjectViewState();
}

class _CreateProjectViewState extends State<_CreateProjectView> {
  final _formKey = GlobalKey<FormState>();
  late ProjectBloc projectBloc;

  var _name = '';
  var _description = '';

  @override
  void initState() {
    projectBloc = context.read<ProjectBloc>();

    context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
    context.read<UsersBloc>().add(UsersEvent.getUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
      listenWhen: (_, current) => switch (current) {
        ProjectCreatedState() || ProjectFailureState() => true,
        _ => false,
      },
      listener: (context, state) {
        final navigator = GoRouter.of(context);
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case ProjectCreatedState(:final project):
            context.read<ProjectsBloc>().add(ProjectsEvent.getProjects());
            messenger.showSnackBar(AppSnackBar.success(context.$.msgProjectCreated(project.name)));
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
                  SaveIconButton(onPressed: save),
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
                          child: TextFormField(
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
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.4,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: context.$.description,
                            ),
                            onSaved: (newValue) => _description = newValue!,
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
                  builder: (_, state) {
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
                  builder: (_, state) {
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

  void save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      projectBloc.add(
        ProjectEvent.create(
          name: _name,
          description: _description,
          organizationID: context.read<OrganizationsSelectionBloc>().state.first.id,
          userID: context.read<UsersSelectionCubit>().state.firstOrNull?.uuid,
          roles: context.read<RolesSelectionBloc>().state,
        ),
      );
    }
  }
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
          create: (_) => UsersSelectionCubit(),
        ),
        BlocProvider(
          create: (_) => RolesSelectionBloc(),
        ),
      ],
      child: _CreateProjectView(),
    );
  }
}
