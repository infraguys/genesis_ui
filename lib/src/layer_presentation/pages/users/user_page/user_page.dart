import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/update_user_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users/user_page/widgets/delete_user_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/users/user_page/widgets/list_of_projects.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_label.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/verified_label.dart';
import 'package:go_router/go_router.dart';

class _UserView extends StatefulWidget {
  const _UserView({required this.userUUID});

  final String userUUID;

  @override
  State<_UserView> createState() => _UserViewState();
}

class _UserViewState extends State<_UserView> {
  final _formKey = GlobalKey<FormState>();
  late _ControllersManager _controllersManager;
  late final UserBloc _userBloc;

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _controllersManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listenWhen: (previous, current) => switch (current) {
          UserUpdatedState() || UserDeletedState() || UserFailureState() || UserLoadedState() => true,
          _ => false,
        },
        listener: (context, state) {
          final navigator = GoRouter.of(context);
          final messenger = ScaffoldMessenger.of(context);

          switch (state) {
            case UserLoadedState(:final user):
              _controllersManager = _ControllersManager(user);

            case UserUpdatedState():
              _userBloc.add(UserEvent.getUser(widget.userUUID));
              messenger.showSnackBar(AppSnackBar.success(context.$.msgUserUpdated(state.user.username)));
              context.read<UsersBloc>().add(UsersEvent.getUsers());

            case UserDeletedState(:final user):
              messenger.showSnackBar(AppSnackBar.success(context.$.msgUserDeleted(user.username)));
              context.read<UsersBloc>().add(UsersEvent.getUsers());
              navigator.pop();

            case UserFailureState(:final message):
              messenger.showSnackBar(AppSnackBar.failure(message));
            default:
          }
        },
        builder: (context, state) {
          if (state is! UserLoadedState) {
            return AppProgressIndicator();
          }
          final user = state.user;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24.0,
              children: [
                Breadcrumbs(
                  items: [
                    BreadcrumbItem(text: context.$.users),
                    BreadcrumbItem(text: user.username),
                  ],
                ),
                ButtonsBar(
                  children: [
                    DeleteUserIconButton(user: user),
                    SaveIconButton(onPressed: () => save(user.uuid)),
                  ],
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      height: 410,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                spacing: 24,
                                children: [
                                  SizedBox(
                                    width: constraints.maxWidth * 0.4,
                                    child: AppTextInput(
                                      controller: _controllersManager.usernameController,
                                      hintText: context.$.username,
                                    ),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.4,
                                    child: AppTextInput(
                                      controller: _controllersManager.firstNameController,
                                      hintText: context.$.firstName,
                                    ),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.4,
                                    child: AppTextInput(
                                      controller: _controllersManager.lastNameController,
                                      hintText: context.$.lastName,
                                    ),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.4,
                                    child: AppTextInput(
                                      controller: _controllersManager.surnameController,
                                      hintText: context.$.surName,
                                    ),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.4,
                                    child: AppTextInput(
                                      controller: _controllersManager.phoneController,
                                      hintText: 'Phone'.hardcoded,
                                    ),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.4,
                                    child: AppTextInput(
                                      controller: _controllersManager.emailController,
                                      hintText: context.$.email,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // spacing: 48,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 8.0,
                                  children: [
                                    Text(context.$.status),
                                    StatusLabel(status: user.status),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 8.0,
                                  children: [
                                    Text(context.$.verification),
                                    VerifiedLabel(isVerified: user.emailVerified),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 8.0,
                                  children: [
                                    Text(context.$.createdAt),
                                    Text(user.createdAt.toString()),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 8.0,
                                  children: [
                                    Text(context.$.updatedAt),
                                    Text(user.updatedAt.toString()),
                                  ],
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.4,
                                  child: AppTextInput.multiLine(
                                    controller: _controllersManager.descriptionController,
                                    hintText: context.$.description,
                                    maxLines: 4,
                                    minLines: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Text(context.$.projects, style: textTheme.headlineLarge),
                ListOfProjects(userUuid: user.uuid),
              ],
            ),
          );
        },
      ),
    );
  }

  void save(String userUUID) {
    if (_formKey.currentState!.validate()) {
      _userBloc.add(
        UserEvent.updateUser(
          UpdateUserParams(
            uuid: userUUID,
            username: _controllersManager.usernameController.text,
            description: _controllersManager.descriptionController.text,
            firstName: _controllersManager.firstNameController.text,
            lastName: _controllersManager.lastNameController.text,
            surname: _controllersManager.surnameController.text,
            phone: _controllersManager.phoneController.text,
            email: _controllersManager.emailController.text,
          ),
        ),
      );
    }
  }
}

class _ControllersManager extends FormControllersManager {
  _ControllersManager(User user)
    : usernameController = TextEditingController(text: user.username),
      descriptionController = TextEditingController(text: user.description),
      firstNameController = TextEditingController(text: user.firstName),
      lastNameController = TextEditingController(text: user.lastName),
      surnameController = TextEditingController(text: user.surname),
      phoneController = TextEditingController(text: user.phone),
      emailController = TextEditingController(text: user.email);

  final TextEditingController usernameController;
  final TextEditingController descriptionController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController surnameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  @override
  List<TextEditingController> get all => [
    usernameController,
    descriptionController,
    firstNameController,
    lastNameController,
    surnameController,
    phoneController,
    emailController,
  ];
}

class UserPage extends StatelessWidget {
  const UserPage({required this.userUUID, super.key});

  final String userUUID;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return UserBloc(context.read<IUsersRepository>())..add(UserEvent.getUser(userUUID));
          },
        ),
        BlocProvider(
          create: (context) {
            return UserProjectsBloc(
              projectsRepository: context.read<IProjectsRepository>(),
              roleBindingsRepository: context.read<IRoleBindingsRepository>(),
              rolesRepository: context.read<IRolesRepository>(),
            )..add(UserProjectsEvent.getProjects(userUUID));
          },
        ),
      ],
      child: _UserView(userUUID: userUUID),
    );
  }
}
