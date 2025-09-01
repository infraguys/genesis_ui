import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';

class DeleteUsersDialog extends StatelessWidget {
  const DeleteUsersDialog._({required this.users, super.key, this.onDelete});

  DeleteUsersDialog.single({required User user, Key? key, VoidCallback? onDelete})
    : this._(
        key: key,
        users: List.generate(1, (_) => user),
        onDelete: onDelete,
      );

  const DeleteUsersDialog.multiple({required List<User> users, Key? key, VoidCallback? onDelete})
    : this._(
        key: key,
        users: users,
        onDelete: onDelete,
      );

  final List<User> users;
  final VoidCallback? onDelete;

  String getContent(BuildContext context) {
    if (users.length == 1) {
      return context.$.deleteUser(users.single.username);
    }
    return context.$.deleteUsers(users.length);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(getContent(context)),
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
