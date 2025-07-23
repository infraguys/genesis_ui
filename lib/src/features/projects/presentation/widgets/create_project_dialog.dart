import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/organization.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/common/shared_widgets/custom_options_view.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/features/projects/presentation/blocs/auth_user_projects_bloc/auth_user_projects_bloc.dart';
import 'package:genesis/src/features/projects/presentation/blocs/project_bloc/project_bloc.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateProjectDialog extends StatefulWidget {
  const CreateProjectDialog({super.key});

  @override
  State<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog> {
  final _formKey = GlobalKey<FormState>();

  late final FocusNode _organizationFocusNode;
  late final FocusNode _userFocusNode;
  late final _ControllersManager _controllersManager;

  @override
  void initState() {
    super.initState();
    _organizationFocusNode = FocusNode();
    _userFocusNode = FocusNode();
    _controllersManager = _ControllersManager();
    final authState = context.read<AuthBloc>().state as AuthenticatedAuthState;
    context.read<OrganizationsBloc>().add(
      OrganizationsEvent.getOrganizationsByUser(authState.user.uuid),
    );
  }

  Organization? _selectedOrganization;
  User? _selectedUser;

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state as AuthenticatedAuthState;

    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectCreatedState) {
          context.read<AuthUserProjectsBloc>().add(AuthUserProjectsEvent.getProjects(authState.user.uuid));
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
                    BlocBuilder<UsersBloc, UsersState>(
                      builder: (context, state) {
                        return RawAutocomplete<User>(
                          textEditingController: _controllersManager.userController,
                          focusNode: _userFocusNode,
                          optionsBuilder: (textEditingValue) {
                            if (state is! UsersLoadedState) {
                              return [];
                            }
                            return state.users.where(
                              (user) => user.username.toLowerCase().contains(textEditingValue.text.toLowerCase()),
                            );
                          },
                          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(hintText: 'Выберите пользователя'),
                            );
                          },
                          displayStringForOption: (option) => option.username,
                          onSelected: (option) {
                            _selectedUser = option;
                            _userFocusNode.unfocus();
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
                        );
                      },
                    ),
                    BlocBuilder<OrganizationsBloc, OrganizationsState>(
                      builder: (context, state) {
                        return RawAutocomplete<Organization>(
                          focusNode: _organizationFocusNode,
                          textEditingController: _controllersManager.organizationSourceController,
                          optionsBuilder: (textEditingValue) {
                            if (state is! OrganizationsLoadedState) {
                              return List.empty();
                            }
                            return state.organizations.where(
                              (org) => org.name.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                            );
                          },
                          fieldViewBuilder: (_, controller, focusNode, _) {
                            return TextFormField(
                              focusNode: focusNode,
                              controller: controller,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(hintText: 'Выберите организацию'),
                            );
                          },
                          displayStringForOption: (option) => option.name,
                          onSelected: (option) {
                            _selectedOrganization = option;
                            _organizationFocusNode.unfocus();
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
                                itemBuilder: (_, index) {
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
                      controller: _controllersManager.projectNameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(hintText: 'Project name'.hardcoded),
                    ),
                    TextFormField(
                      controller: _controllersManager.projectDescriptionController,
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
          ListenableBuilder(
            listenable: Listenable.merge(_controllersManager.all),
            builder: (context, asyncSnapshot) {
              return TextButton(
                onPressed: _controllersManager.allFilled
                    ? () {
                        context.read<ProjectBloc>().add(
                          ProjectEvent.create(
                            userUuid: _selectedUser?.uuid ?? authState.user.uuid,
                            name: _controllersManager.projectNameController.text,
                            description: _controllersManager.projectDescriptionController.text,
                            organization: _selectedOrganization!.uuid,
                          ),
                        );
                      }
                    : null,
                child: Text(context.$.ok),
              );
            },
          ),
        ],
      ),
    );
  }
}

final class _ControllersManager extends FormControllersManager {
  final userController = TextEditingController();
  final projectNameController = TextEditingController();
  final projectDescriptionController = TextEditingController();
  final organizationSourceController = TextEditingController();

  @override
  List<TextEditingController> get all => [
    projectNameController,
    projectDescriptionController,
    organizationSourceController,
  ];

  @override
  bool get allFilled => all.every((controller) => controller.text.isNotEmpty);
}
