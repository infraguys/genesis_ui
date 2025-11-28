import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/projects/presentation/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/update_user_params.dart';
import 'package:genesis/src/features/users/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/features/users/presentation/pages/user_page/widgets/list_of_projects.dart';
import 'package:genesis/src/injection/main_di_factory.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/spacing.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirm_email_icon_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/delete_elevated_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/form_card.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/id_widget.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/metadata_table.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/page_layout.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/user_status_widget.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/verified_label.dart';
import 'package:go_router/go_router.dart';

part 'widgets/confirm_email_btn.dart';
part 'widgets/delete_user_btn.dart';

class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _formKey = GlobalKey<FormState>();

  late final UserBloc _userBloc;

  late String _username;
  late String? _description;
  late String? _firstName;
  late String? _lastName;
  late String? _surname;
  late String? _phone;
  late String _email;

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    super.initState();
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
          case UserUpdatedState(:final user):
            messenger.showSnackBar(AppSnackBar.success(context.$.msgUserUpdated(user.username)));
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
      child: BlocBuilder<UserBloc, UserState>(
        buildWhen: (_, current) => current is UserLoadingState || current is UserLoadedState,
        builder: (context, state) {
          if (state is! UserLoadedState) {
            return AppProgressIndicator();
          }
          final UserLoadedState(:user) = state;
          return PageLayout(
            breadcrumbs: [
              BreadcrumbItem(text: context.$.users),
              BreadcrumbItem(text: user.username),
            ],
            buttons: [
              _DeleteUserButton(user: user),
              _ConfirmEmailButton(user: user),
              SaveIconButton(onPressed: () => save(user.uuid)),
            ],
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: Spacing.s16,
                  children: [
                    FormCard(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.account_circle, size: 100),
                          SizedBox(width: 32),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: Spacing.s16,
                            children: [
                              IdWidget(id: user.uuid.raw),
                              SizedBox(
                                width: 500,
                                child: AppTextFormInput(
                                  initialValue: _username,
                                  helperText: context.$.username,
                                  onSaved: (value) => _username = value!,
                                  validator: (value) => switch (value) {
                                    _ when value!.isEmpty => context.$.requiredField,
                                    _ => null,
                                  },
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          MetadataTable(
                            statusWidget: UserStatusWidget(status: user.status),
                            verificationStatusWidget: VerifiedLabel(isVerified: user.emailVerified),
                            createdAt: user.createdAt,
                            updatedAt: user.updatedAt,
                          ),
                        ],
                      ),
                    ),
                    FormCard(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final columnWidth = (constraints.maxWidth - 3 * Spacing.s16) / 4;
                          return Column(
                            spacing: Spacing.s16,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: Spacing.s16,
                                children: [
                                  SizedBox(
                                    width: columnWidth,
                                    child: AppTextFormInput(
                                      initialValue: _firstName,
                                      helperText: context.$.firstName,
                                      onSaved: (value) => _firstName = value!,
                                    ),
                                  ),
                                  SizedBox(
                                    width: columnWidth,
                                    child: AppTextFormInput(
                                      initialValue: _lastName,
                                      helperText: context.$.lastName,
                                      onSaved: (value) => _lastName = value!,
                                    ),
                                  ),
                                  SizedBox(
                                    width: columnWidth,
                                    child: AppTextFormInput(
                                      initialValue: _surname,
                                      helperText: context.$.surName,
                                      onSaved: (value) => _surname = value!,
                                    ),
                                  ),
                                  SizedBox(
                                    width: columnWidth,
                                    child: DropdownMenuFormField<bool>(
                                      menuStyle: MenuStyle(
                                        fixedSize: WidgetStatePropertyAll(Size.fromWidth(columnWidth)),
                                      ),
                                      width: double.infinity,
                                      initialSelection: false,
                                      enabled: false,
                                      helperText: context.$.otp,
                                      requestFocusOnTap: false,
                                      // onSaved: (value) => _nodeType = value!,
                                      dropdownMenuEntries: [
                                        DropdownMenuEntry(
                                          value: true,
                                          label: 'Otp enabled',
                                        ),
                                        DropdownMenuEntry(
                                          value: false,
                                          label: 'Otp disabled',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: Spacing.s16,
                                children: [
                                  SizedBox(
                                    width: (columnWidth * 2) + Spacing.s16,
                                    child: AppTextFormInput(
                                      initialValue: _email,
                                      helperText: context.$.email,
                                      onSaved: (value) => _email = value!,
                                    ),
                                  ),
                                  SizedBox(
                                    width: (columnWidth * 2) + Spacing.s16,
                                    child: AppTextFormInput(
                                      initialValue: _phone,
                                      helperText: context.$.phoneNumber,
                                      onSaved: (value) => _phone = value!,
                                    ),
                                  ),
                                ],
                              ),
                              AppTextFormInput.description(
                                initialValue: _description,
                                helperText: context.$.description,
                                onSaved: (value) => _description = value!,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    ListOfProjects(userUuid: user.uuid),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void save(UserID userId) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final params = UpdateUserParams(
        id: userId,
        username: _username,
        description: _description,
        firstName: _firstName,
        lastName: _lastName,
        surname: _surname,
        phone: _phone,
        email: _email,
      );
      _userBloc.add(UserEvent.update(params));
    }
  }
}

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({
    required this.userID,
    super.key,
  });

  final UserID userID;

  @override
  Widget build(BuildContext context) {
    final diFactory = MainDiFactory();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => diFactory.users.createUserBloc(context)..add(UserEvent.getUser(userID)),
        ),
        BlocProvider(
          create: (context) => UserProjectsBloc(
            projectsRepository: context.read<IProjectsRepository>(),
            roleBindingsRepository: context.read<IRoleBindingsRepository>(),
            rolesRepository: context.read<IRolesRepository>(),
          )..add(UserProjectsEvent.getProjects(userID)),
        ),
      ],
      child: _View(),
    );
  }
}

//DropdownMenuFormField<NodeType>(
//                           menuStyle: MenuStyle(
//                             fixedSize: WidgetStatePropertyAll(Size.fromWidth(constraints.maxWidth * 0.4)),
//                           ),
//                           width: double.infinity,
//                           initialSelection: _nodeType,
//                           helperText: context.$.nodeType,
//                           requestFocusOnTap: false,
//                           onSaved: (value) => _nodeType = value!,
//                           dropdownMenuEntries: [
//                             DropdownMenuEntry(
//                               value: NodeType.vm,
//                               label: context.$.virtualMachine,
//                             ),
//                             DropdownMenuEntry(
//                               value: NodeType.hw,
//                               label: context.$.hardware,
//                             ),
//                           ],
//                         ),
