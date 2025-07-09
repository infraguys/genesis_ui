import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/domain/entities/user.dart';
import 'package:genesis/src/presentation/features/users/widgets/change_user_password_dialog.dart';
import 'package:genesis/src/presentation/features/users/widgets/delete_user_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UsersActionsPopupMenuButton extends StatelessWidget {
  const UsersActionsPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<User>();
    return PopupMenuButton<String>(
      onSelected: (value) {
        final child = switch (value) {
          'change_password' => ChangeUserPasswordDialog(),
          'delete_user' => DeleteUserDialog(),
          _ => SizedBox.shrink(),
        };
        showDialog<void>(
          context: context,
          builder: (_) {
            return Provider.value(
              value: user,
              child: child,
            );
          },
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      useRootNavigator: true,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text('Подтвердить email'.hardcoded),
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('Подтвердить email?'),
                    actions: [
                      TextButton(
                        onPressed: context.pop,
                        child: Text(context.$.cancel),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Ок'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          PopupMenuItem(
            value: 'change_password',
            child: Text(context.$.changeUserPassword),
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (_) {
                  return Provider.value(
                    value: user,
                    child: ChangeUserPasswordDialog(),
                  );
                },
              );
            },
          ),
          PopupMenuItem(child: Text('Сменить email'.hardcoded)),
          PopupMenuItem(child: Text('Блокировать'.hardcoded)),
          PopupMenuItem(
            value: 'delete_user',
            labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Colors.red)),
            child: Text(context.$.delete),
          ),
        ];
      },
    );
  }
}
