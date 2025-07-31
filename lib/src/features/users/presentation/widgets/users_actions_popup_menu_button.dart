import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/users/presentation/widgets/block_user_dialog.dart';
import 'package:genesis/src/features/users/presentation/widgets/change_user_password_dialog.dart';
import 'package:genesis/src/features/users/presentation/widgets/delete_user_dialog.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UsersActionsPopupMenuButton extends StatelessWidget {
  const UsersActionsPopupMenuButton({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_PopupBtnValue>(
      icon: Icon(Icons.more_vert),
      onSelected: (value) {
        final child = switch (value) {
          _PopupBtnValue.changePassword => ChangeUserPasswordDialog(),
          _PopupBtnValue.deleteUser => DeleteUserDialog(),
          _PopupBtnValue.blockUser => BlockUserDialog(),
        };
        showDialog<void>(
          context: context,
          builder: (_) {
            return Provider.value(
              value: context.read<User>(),
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
            child: Text(context.$.edit),
            onTap: () {
              final user = context.read<User>();
              context.goNamed(
                AppRoutes.user.name,
                pathParameters: {'uuid': user.uuid},
                extra: user,
              );
            },
          ),
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
            value: _PopupBtnValue.changePassword,
            child: Text(context.$.changeUserPassword),
          ),
          PopupMenuItem(
            child: Text('Сменить email'.hardcoded),
          ),
          PopupMenuItem(
            value: _PopupBtnValue.blockUser,
            child: Text('Блокировать'.hardcoded),
          ),
          PopupMenuItem(
            value: _PopupBtnValue.deleteUser,
            labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Colors.red)),
            child: Text(context.$.delete),
          ),
        ];
      },
    );
  }
}

enum _PopupBtnValue {
  changePassword,
  blockUser,
  deleteUser,
}
