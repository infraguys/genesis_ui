import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:go_router/go_router.dart';

class DeleteUserDialog extends StatelessWidget {
  const DeleteUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<User>();
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
  }
}
