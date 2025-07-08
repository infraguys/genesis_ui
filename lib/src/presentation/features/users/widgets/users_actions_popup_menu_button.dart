import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/domain/entities/user.dart';
import 'package:genesis/src/presentation/features/users/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/presentation/features/users/widgets/change_user_password_dialog.dart';
import 'package:go_router/go_router.dart';

class UsersActionsPopupMenuButton extends StatelessWidget {
  const UsersActionsPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<User>();
    return PopupMenuButton<int>(
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
                      TextButton(onPressed: context.pop, child: Text('Отмена')),
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
            child: Text('Сменить пароль'.hardcoded),
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return ChangeUserPasswordDialog(user: user);
                },
              );
            },
          ),
          PopupMenuItem(child: Text('Сменить email'.hardcoded)),
          PopupMenuItem(child: Text('Блокировать'.hardcoded)),
          PopupMenuItem(
            labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Colors.red)),
            child: Text('Удалить'.hardcoded),
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('Удалить пользователя ${user.username}?'),
                    actions: [
                      TextButton(onPressed: context.pop, child: Text('Отмена')),
                      TextButton(
                        onPressed: () {
                          context.pop();
                          context.read<UserBloc>().add(UserEvent.deleteUser(user.uuid));
                        },
                        child: Text('Ок'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ];
      },
    );
  }
}
