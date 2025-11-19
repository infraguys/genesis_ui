import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/users/domain/params/create_user_params.dart';
import 'package:genesis/src/features/users/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/injection/di_factory.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/spacing.dart';
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

  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  var _username = '';
  var _firstname = '';
  var _lastname = '';
  var _surname = '';
  var _email = '';
  var _phone = '';
  var _description = '';
  var _password = '';

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
          case UserCreatedState():
            final msg = context.$.msgUserCreated(state.user.username);
            messenger.showSnackBar(AppSnackBar.success(msg));

            context.read<UsersBloc>().add(UsersEvent.getUsers());
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
                            child: ValueListenableBuilder(
                              valueListenable: _isPasswordVisible,
                              builder: (context, isVisible, _) {
                                return AppTextFormInput.password(
                                  helperText: context.$.password,
                                  obscureText: !isVisible,
                                  suffixIcon: GestureDetector(
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Icon(
                                        applyTextScaling: true,
                                        isVisible ? Icons.visibility : Icons.visibility_off,
                                        color: Colors.white24,
                                      ),
                                    ),
                                    onTap: () => _isPasswordVisible.value = !isVisible,
                                  ),
                                  onSaved: (newValue) => _password = newValue!,
                                  validator: (value) => switch (value) {
                                    _ when value!.isEmpty => context.$.requiredField,
                                    _ when value.length < 8 => context.$.errorMinLength(8),
                                    _ => null,
                                  },
                                );
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

      final params = CreateUserParams(
        username: _username,
        firstName: _firstname,
        lastName: _lastname,
        email: _email,
        password: _password,
      );
      _userBloc.add(UserEvent.createUser(params));
    }
  }
}

class CreateUserDialog extends StatelessWidget {
  const CreateUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final diFactory = DiFactory();
    return BlocProvider(
      create: (context) => diFactory.createUserBloc(context),
      child: _View(),
    );
  }
}
