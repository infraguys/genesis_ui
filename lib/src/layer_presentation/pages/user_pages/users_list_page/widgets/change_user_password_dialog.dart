import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/change_user_password_params.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangeUserPasswordDialog extends StatefulWidget {
  const ChangeUserPasswordDialog({super.key});

  @override
  State<ChangeUserPasswordDialog> createState() => _ChangeUserPasswordDialogState();
}

class _ChangeUserPasswordDialogState extends State<ChangeUserPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  late final UserBloc _userBloc;

  var _oldPassword = '';
  var _newPassword = '';

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    super.initState();
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
              onSaved: (newValue) => _oldPassword = newValue!,
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
              onSaved: (newValue) => _newPassword = newValue!,
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
        TextButton(
          onPressed: changePassword,
          child: Text(context.$.ok),
        ),
      ],
    );
  }

  void changePassword() {
    final user = context.read<User>();
    _userBloc.add(
      UserEvent.changePassword(
        ChangeUserPasswordParams(
          id: user.uuid,
          oldPassword: _oldPassword,
          newPassword: _newPassword,
        ),
      ),
    );
  }
}
