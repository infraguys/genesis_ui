import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/organization.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/common/shared_widgets/custom_options_view.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/features/projects/presentation/blocs/project_bloc/project_bloc.dart';
import 'package:genesis/src/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateProjectDialog extends StatefulWidget {
  const CreateProjectDialog({super.key});

  @override
  State<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _organizationController;
  late final TextEditingController _userController;

  late AuthenticatedAuthState authState;

  @override
  void initState() {
    super.initState();
    authState = context.read<AuthBloc>().state as AuthenticatedAuthState;
    context.read<OrganizationsBloc>().add(
      OrganizationsEvent.getOrganizationsByUser(authState.user.uuid),
    );

    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _organizationController = TextEditingController();
    _userController = TextEditingController(text: authState.user.username);
  }

  Organization? _selectedOrganization;

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state as AuthenticatedAuthState;

    // final project = context.read<Project>();
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectCreatedState) {
          context.read<ProjectsBloc>().add(ProjectsEvent.getProjects(authState.user.uuid));
          context.pop();
        }
      },
      child: AlertDialog(
        title: Text('Создание проекта'),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 24,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawAutocomplete<User>(
                    textEditingController: _userController,
                    focusNode: FocusNode(),
                    optionsBuilder: (textEditingValue) {
                      return [
                        authState.user,
                      ].where((user) => user.username.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                    },
                    fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Выберите пользователя',
                        ),
                      );
                    },
                    onSelected: (option) {
                      _userController.text = option.username;
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          color: Colors.grey[850],
                          elevation: 4,
                          borderRadius: BorderRadius.circular(8),
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: options.length,
                            separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey[700]),
                            itemBuilder: (context, index) {
                              final option = options.elementAt(index);
                              return InkWell(
                                onTap: () => onSelected(option),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(option.username, style: const TextStyle(color: Colors.white)),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                    BlocBuilder<OrganizationsBloc, OrganizationsState>(
                      builder: (context, state) {
                        return RawAutocomplete<Organization>(
                          focusNode: FocusNode(),
                          textEditingController: _organizationController,
                          optionsBuilder: (textEditingValue) {
                            if (state is! OrganizationsLoadedState) {
                              return [];
                            }
                            return state.organizations.where(
                              (org) => org.name.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                            );
                          },
                          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                            return TextFormField(
                              focusNode: focusNode,
                              controller: controller,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(hintText: 'Выберите организацию'),
                            );
                          },
                          onSelected: (option) {
                            _selectedOrganization = option;
                            _organizationController.text = option.name;
                          },
                          optionsViewBuilder: (context, onSelected, options) {
                            if (state is! OrganizationsLoadedState) {
                              return Center(child: CupertinoActivityIndicator());
                            }
                            return CustomOptionsView(
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: options.length,
                                separatorBuilder: (_, _) => Divider(height: 1, color: Colors.grey[700]),
                                itemBuilder: (context, index) {
                                  final option = options.elementAt(index);
                                  return InkWell(
                                    onTap: () => onSelected(option),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(option.name, style: const TextStyle(color: Colors.white)),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                    },
                  ),
                  TextFormField(
                    controller: _nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: 'Project name'.hardcoded),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: 'Project description'.hardcoded),
                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: context.pop, child: Text(context.$.cancel)),
          TextButton(
            onPressed: () {
              context.read<ProjectBloc>().add(
                ProjectEvent.create(
                  name: _nameController.text,
                  description: _descriptionController.text,
                  organization: _selectedOrganization!.uuid,
                ),
              );
            },
          child: Text(context.$.ok),
        ),
      ],
      ),
    );
  }
}
