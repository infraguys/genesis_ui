import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';

class DeleteUserDialog extends StatelessWidget {
  const DeleteUserDialog({required this.users, super.key, this.onDelete});

  final List<User> users;
  final VoidCallback? onDelete;

  String getContent(List<User> users) {
    if (users.length == 1) {
      return 'Удалить пользователя ${users.single.username}?';
    }
    return 'Удалить выбранных(${users.length}) пользователей?';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(getContent(users)),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text(context.$.cancel),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Palette.colorF04C4C),
          onPressed: () {
            context.pop();
            onDelete?.call();
          },
          child: Text(context.$.ok),
        ),
      ],
    );
  }
}
