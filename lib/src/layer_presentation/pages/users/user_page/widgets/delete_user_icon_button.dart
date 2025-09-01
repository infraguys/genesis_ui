import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_users_dialog.dart';

class DeleteUserIconButton extends StatelessWidget {
  const DeleteUserIconButton({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return DeleteIconButton(
      onPressed: () async {
        final userBloc = context.read<UserBloc>();
        await showDialog<void>(
          context: context,
          builder: (context) {
            final users = List.generate(1, (_) => user);
            return DeleteUsersDialog(
              users: users,
              onDelete: () => userBloc.add(UserEvent.deleteUser(users.single)),
            );
          },
        );
      },
    );
  }
}
