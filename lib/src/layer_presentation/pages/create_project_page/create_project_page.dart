import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';
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
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  final _formKey = GlobalKey<FormState>();

  late _ControllersManager _controllersManager;

  @override
  void initState() {
    context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
    context.read<UsersBloc>().add(UsersEvent.getUsers());
    context.read<RolesBloc>().add(RolesEvent.getRoles());
    _controllersManager = _ControllersManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectCreatedState) {
          final authState = context.read<AuthBloc>().state as AuthenticatedAuthState;
          context.read<ProjectsBloc>().add(ProjectsEvent.getProjects());
          final navigator = GoRouter.of(context);

          final snack = SnackBar(
            duration: const Duration(milliseconds: 500),
            backgroundColor: Palette.color6DCF91,
            content: Text(context.$.success),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack).closed.then((_) => navigator.pop());
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
              Form(
                key: _formKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 24,
                  children: [
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        controller: _controllersManager.nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: context.$.name,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'required'.hardcoded;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _controllersManager.descriptionController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: context.$.description,
                        ),
                      ),
                    ),
                  ],
                ),
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
              Text(context.$.role(3), style: TextStyle(color: Colors.white54, fontSize: 24)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Palette.color6DCF91),
                      ),
                      onPressed: () => save(context),
                      child: Text(context.$.create),
                    ),
                  ),
                ],
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
          roleUuid: context.read<RolesSelectionBloc>().state.first.uuid,
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
