import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/domain/entities/user.dart';
import 'package:genesis/src/presentation/features/users/blocs/user_bloc/user_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangeUserPasswordDialog extends StatefulWidget {
  const ChangeUserPasswordDialog({super.key, required this.user});

  final User user;

  @override
  State<ChangeUserPasswordDialog> createState() => _ChangeUserPasswordDialogState();
}

class _ChangeUserPasswordDialogState extends State<ChangeUserPasswordDialog> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool get isOkBtnEnabled {
    return _oldPasswordController.text.isNotEmpty && _newPasswordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.$.changeUserPassword),
            TextFormField(
              controller: _oldPasswordController,
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
              controller: _newPasswordController,
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
          listenable: Listenable.merge([_oldPasswordController, _newPasswordController]),
          builder: (context, _) {
            return TextButton(
              onPressed: null,
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
      UserEvent.changePassword(uuid: user.uuid, oldPassword: 'cce', newPassword: 'cwcw'),
    );
  }
}
