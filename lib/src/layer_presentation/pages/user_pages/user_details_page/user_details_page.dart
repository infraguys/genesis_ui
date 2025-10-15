import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/update_user_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/user_pages/user_details_page/widgets/list_of_projects.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/confirm_email_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/confirmation_dialog.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_widgets/user_status_widget.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/verified_label.dart';
import 'package:go_router/go_router.dart';

part './widgets/confirm_email_btn.dart';

part './widgets/delete_user_btn.dart';

part './widgets/save_user_btn.dart';

class _UserDetailsView extends StatefulWidget {
  const _UserDetailsView();

  @override
  State<_UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<_UserDetailsView> {
  final _formKey = GlobalKey<FormState>();
  late final UserBloc _userBloc;

  late String _username;
  late String _description;
  late String _firstName;
  late String _lastName;
  late String? _surname;
  late String? _phone;
  late String _email;

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (_, current) => current.shouldListen,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case UserLoadedState(:final user):
            _username = user.username;
            _description = user.description;
            _firstName = user.firstName;
            _lastName = user.lastName;
            _surname = user.surname;
            _phone = user.phone;
            _email = user.email;
          case UserUpdatedState():
            messenger.showSnackBar(AppSnackBar.success(context.$.msgUserUpdated(state.user.username)));
            context.read<UsersBloc>().add(UsersEvent.getUsers());

          case UserDeletedState(:final user):
            messenger.showSnackBar(AppSnackBar.success(context.$.msgUserDeleted(user.username)));
            context.read<UsersBloc>().add(UsersEvent.getUsers());
            context.pop();

          case UserPermissionFailureState(:final message):
            messenger.showSnackBar(AppSnackBar.failure(context.$.msgPermissionDenied(message)));

          case UserFailureState(:final message):
            messenger.showSnackBar(AppSnackBar.failure(message));
          default:
        }
      },
      child: Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
          buildWhen: (_, current) => current.shouldBuild,
          builder: (context, state) {
            if (state is! UserLoadedState) {
              return AppProgressIndicator();
            }
            final UserLoadedState(:user) = state;
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
                      _DeleteUserButton(user: user),
                      _ConfirmEmailButton(user: user),
                      _SaveUserButton(onPressed: () => save(user.uuid)),
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
                                      child: TextFormField(
                                        initialValue: _username,
                                        decoration: InputDecoration(
                                          hintText: context.$.username,
                                        ),
                                        onSaved: (newValue) => _username = newValue!,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.4,
                                      child: TextFormField(
                                        initialValue: _firstName,
                                        decoration: InputDecoration(
                                          hintText: context.$.firstName,
                                        ),
                                        onSaved: (newValue) => _firstName = newValue!,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.4,
                                      child: TextFormField(
                                        initialValue: _lastName,
                                        decoration: InputDecoration(
                                          hintText: context.$.lastName,
                                        ),
                                        onSaved: (newValue) => _lastName = newValue!,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.4,
                                      child: TextFormField(
                                        initialValue: _surname,
                                        decoration: InputDecoration(
                                          hintText: context.$.surName,
                                        ),
                                        onSaved: (newValue) => _surname = newValue!,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.4,
                                      child: TextFormField(
                                        initialValue: _phone,
                                        decoration: InputDecoration(
                                          hintText: 'Phone'.hardcoded,
                                        ),
                                        onSaved: (newValue) => _phone = newValue!,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.4,
                                      child: TextFormField(
                                        initialValue: _email,
                                        decoration: InputDecoration(
                                          hintText: context.$.email,
                                        ),
                                        onSaved: (newValue) => _email = newValue!,
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
                                      UserStatusWidget(status: user.status),
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
                                    child: TextFormField(
                                      initialValue: _description,
                                      decoration: InputDecoration(
                                        hintText: context.$.description,
                                      ),
                                      onSaved: (newValue) => _description = newValue!,
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
                  ListOfProjects(userUuid: user.uuid),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void save(UserUUID userUUID) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _userBloc.add(
        UserEvent.updateUser(
          UpdateUserParams(
            uuid: userUUID,
            username: _username,
            description: _description,
            firstName: _firstName,
            lastName: _lastName,
            surname: _surname,
            phone: _phone,
            email: _email,
          ),
        ),
      );
    }
  }
}

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({required this.userUUID, super.key});

  final UserUUID userUUID;

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
      child: _UserDetailsView(),
    );
  }
}
