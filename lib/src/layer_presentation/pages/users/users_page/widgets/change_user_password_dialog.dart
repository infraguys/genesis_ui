import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/change_user_password_params.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangeUserPasswordDialog extends StatefulWidget {
  const ChangeUserPasswordDialog({super.key});

  @override
  State<ChangeUserPasswordDialog> createState() => _ChangeUserPasswordDialogState();
}

class _ChangeUserPasswordDialogState extends State<ChangeUserPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = _ChangePasswordFormControllers();

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.$.changePassword),
            TextFormField(
              controller: _controllers.oldPassword,
              autovalidateMode: AutovalidateMode.onUnfocus,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(hintText: context.$.oldPassword),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'required'.hardcoded;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _controllers.newPassword,
              autovalidateMode: AutovalidateMode.onUnfocus,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(hintText: context.$.newPassword),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'required'.hardcoded;
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: context.pop, child: Text(context.$.cancel)),
        ListenableBuilder(
          listenable: Listenable.merge(_controllers.all),
          builder: (context, _) {
            return TextButton(
              onPressed: _controllers.allFilled ? () => changePassword(context) : null,
              child: Text(context.$.ok),
            );
          },
        ),
      ],
    );
  }

  void changePassword(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    final user = context.read<User>();
    userBloc.add(
      UserEvent.changePassword(
        ChangeUserPasswordParams(
          uuidUUID: user.uuid,
          oldPassword: _controllers.oldPassword.text,
          newPassword: _controllers.newPassword.text,
        ),
      ),
    );
  }
}

class _ChangePasswordFormControllers extends FormControllersManager {
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();

  @override
  List<TextEditingController> get all => [oldPassword, newPassword];
}
