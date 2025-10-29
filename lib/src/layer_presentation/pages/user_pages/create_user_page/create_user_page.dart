import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/users/domain/params/create_user_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/spacing.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_modal_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/general_dialog_layout.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _formKey = GlobalKey<FormState>();
  late final UserBloc _userBloc;

  final _passwordController = TextEditingController();
  final _repeatedPasswordController = TextEditingController();

  var _username = '';
  var _firstname = '';
  var _lastname = '';
  var _surname = '';
  var _email = '';
  var _phone = '';
  var _description = '';

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _repeatedPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (_, current) => current.shouldListen,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case UserCreatedState():
            context.read<UsersBloc>().add(UsersEvent.getUsers());
            messenger.showSnackBar(
              AppSnackBar.success(context.$.msgUserCreated(state.user.username)),
            );
            context.pop();
          case UserFailureState(:final message):
            messenger.showSnackBar(AppSnackBar.failure(message));
          default:
        }
      },
      child: GeneralDialogLayout(
        constraints: BoxConstraints(maxWidth: 900),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: Spacing.s16,
            children: [
              Row(
                children: [
                  Icon(Icons.account_circle, size: 100),
                  SizedBox(width: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16.0,
                    children: [
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
                ],
              ),
              Divider(color: Palette.color1B1B1D),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columnWidth = (constraints.maxWidth - 3 * Spacing.s16) / 4;
                  return Column(
                    spacing: Spacing.s16,
                    children: [
                      Row(
                        spacing: Spacing.s16,
                        children: [
                          SizedBox(
                            width: columnWidth * 2 + Spacing.s16,
                            child: AppTextFormInput(
                              initialValue: _firstname,
                              helperText: context.$.firstName,
                              onSaved: (newValue) => _firstname = newValue!,
                            ),
                          ),
                          SizedBox(
                            width: columnWidth * 2 + Spacing.s16,
                            child: AppTextFormInput(
                              initialValue: _email,
                              helperText: context.$.email,
                              onSaved: (newValue) => _email = newValue!,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: Spacing.s16,
                        children: [
                          SizedBox(
                            width: columnWidth * 2 + Spacing.s16,
                            child: AppTextFormInput(
                              initialValue: _lastname,
                              helperText: context.$.lastName,
                              onSaved: (newValue) => _lastname = newValue!,
                            ),
                          ),
                          SizedBox(
                            width: columnWidth * 2 + Spacing.s16,
                            child: AppTextFormInput(
                              initialValue: _phone,
                              helperText: context.$.phoneNumber,
                              onSaved: (newValue) => _phone = newValue!,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: Spacing.s16,
                        children: [
                          SizedBox(
                            width: columnWidth * 2 + Spacing.s16,
                            child: AppTextFormInput(
                              initialValue: _surname,
                              helperText: context.$.surName,
                              onSaved: (newValue) => _surname = newValue!,
                            ),
                          ),
                          SizedBox(
                            width: columnWidth * 2 + Spacing.s16,
                            child: AppTextFormInput(
                              // initialValue: _password,
                              controller: _passwordController,
                              helperText: context.$.password,

                              onChanged: (value) => _passwordController.text = value,
                              obscureText: true,
                              maxLines: 1,
                              validator: (value) => switch (value) {
                                _ when value!.isEmpty => context.$.requiredField,
                                _ => null,
                              },
                            ),
                          ),
                        ],
                      ),
                      AppTextFormInput.description(
                        initialValue: _description,
                        helperText: context.$.description,
                        onSaved: (newValue) => _description = newValue!,
                      ),
                    ],
                  );
                },
              ),
              SaveIconButton(onPressed: save),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final isOk = await showDialog<bool>(
        context: context,
        builder: (context) => AppModalDialog(
          content: SizedBox(
            width: 400,
            child: AppTextFormInput(
              controller: _repeatedPasswordController,
              helperText: context.$.repeatPassword,
              onChanged: (value) => _repeatedPasswordController.text = value,
              obscureText: true,
              maxLines: 1,
              validator: (value) {
                switch (value) {
                  case _ when value!.isNotEmpty && value != _passwordController.text:
                    return context.$.passwordsDoNotMatch;
                  default:
                    return null;
                }
              },
            ),
          ),
          onPressed: () {
            if (_passwordController.text == _repeatedPasswordController.text) {
              _repeatedPasswordController.clear();
              context.pop(true);
            }
          },
          onCancel: () => _repeatedPasswordController.clear(),
        ),
      );

      if (isOk != null && isOk) {
        final params = CreateUserParams(
          username: _username,
          firstName: _firstname,
          lastName: _lastname,
          email: _email,
          password: _passwordController.text,
        );
        _userBloc.add(UserEvent.createUser(params));
      }
    }
  }
}

class CreateUserDialog extends StatelessWidget {
  const CreateUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(context.read<IUsersRepository>()),
        ),
      ],
      child: _View(),
    );
  }
}
