import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/update_user_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/user_pages/user_details_page/widgets/list_of_projects.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/confirm_email_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_widgets/user_status_widget.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/verified_label.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

part './widgets/confirm_email_btn.dart';

part './widgets/delete_user_btn.dart';

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
      child: Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
          buildWhen: (_, current) => current.shouldBuild,
          builder: (context, state) {
            if (state is! UserLoadedState) {
              return AppProgressIndicator();
            }
            final UserLoadedState(:user) = state;
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                        SaveIconButton(onPressed: () => save(user.uuid)),
                      ],
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.account_circle, size: 100),
                                SizedBox(width: 32),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 16.0,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'ID: ',
                                        children: [
                                          WidgetSpan(
                                            alignment: PlaceholderAlignment.middle,
                                            child: SelectableText(
                                              user.uuid.value,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: GoogleFonts.robotoMono().fontFamily,
                                              ),
                                            ),
                                          ),
                                          WidgetSpan(child: const SizedBox(width: 8)),
                                          WidgetSpan(
                                            alignment: PlaceholderAlignment.middle,
                                            child: IconButton(
                                              icon: Icon(Icons.copy, color: Colors.white, size: 18),
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(text: user.uuid.value));
                                                final msg = context.$.msgCopiedToClipboard(user.uuid.value);
                                                ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.success(msg));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 500,
                                      child: AppTextFormInput(
                                        initialValue: _username,
                                        helperText: context.$.username,
                                        onSaved: (newValue) => _username = newValue!,
                                        validator: (value) => switch (value) {
                                          _ when value!.isEmpty => context.$.requiredField,
                                          _ => null,
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Table(
                                  defaultColumnWidth: FixedColumnWidth(200),
                                  children: [
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(context.$.status),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: UserStatusWidget(status: user.status),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(context.$.verification),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: VerifiedLabel(isVerified: user.emailVerified),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(context.$.createdAt),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(DateFormat('dd.MM.yyyy HH:mm').format(user.createdAt)),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(context.$.updatedAt),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(DateFormat('dd.MM.yyyy HH:mm').format(user.updatedAt)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          spacing: 16.0,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 16.0,
                              children: [
                                Expanded(
                                  child: Column(
                                    spacing: 16.0,
                                    children: [
                                      AppTextFormInput(
                                        initialValue: _firstName,
                                        helperText: context.$.firstName,
                                        onSaved: (newValue) => _firstName = newValue!,
                                      ),
                                      AppTextFormInput(
                                        initialValue: _lastName,
                                        helperText: context.$.lastName,
                                        onSaved: (newValue) => _lastName = newValue!,
                                      ),
                                      AppTextFormInput(
                                        initialValue: _surname,
                                        helperText: context.$.surName,
                                        onSaved: (newValue) => _surname = newValue!,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: 16.0,
                                    children: [
                                      AppTextFormInput(
                                        initialValue: _email,
                                        helperText: context.$.email,
                                        onSaved: (newValue) => _email = newValue!,
                                      ),
                                      AppTextFormInput(
                                        initialValue: _phone,
                                        helperText: context.$.phoneNumber,
                                        onSaved: (newValue) => _phone = newValue!,
                                      ),
                                      DropdownMenuFormField<bool>(
                                        // menuStyle: MenuStyle(
                                        //   fixedSize: WidgetStatePropertyAll(Size.fromWidth(constraints.maxWidth * 0.4)),
                                        // ),
                                        width: double.infinity,
                                        initialSelection: false,
                                        enabled: false,
                                        helperText: context.$.otp,
                                        requestFocusOnTap: false,
                                        // onSaved: (newValue) => _nodeType = newValue!,
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            AppTextFormInput(
                              initialValue: _description,
                              helperText: context.$.description,
                              onSaved: (newValue) => _description = newValue!,
                              maxLines: 2,
                              minLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListOfProjects(userUuid: user.uuid),
                  ],
                ),
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
      final params = UpdateUserParams(
        id: userUUID,
        username: _username,
        description: _description,
        firstName: _firstName,
        lastName: _lastName,
        surname: _surname,
        phone: _phone,
        email: _email,
      );
      _userBloc.add(UserEvent.updateUser(params));
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

//DropdownMenuFormField<NodeType>(
//                           menuStyle: MenuStyle(
//                             fixedSize: WidgetStatePropertyAll(Size.fromWidth(constraints.maxWidth * 0.4)),
//                           ),
//                           width: double.infinity,
//                           initialSelection: _nodeType,
//                           helperText: context.$.nodeType,
//                           requestFocusOnTap: false,
//                           onSaved: (newValue) => _nodeType = newValue!,
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
