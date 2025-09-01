import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_users_dialog.dart';

class DeleteUserElevatedButton extends StatelessWidget {
  const DeleteUserElevatedButton({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return DeleteIconButton(
      onPressed: () async {
        final userBloc = context.read<UserBloc>();
        await showDialog<void>(
          context: context,
          builder: (context) {
            return DeleteUsersDialog.single(
              user: user,
              onDelete: () => userBloc.add(UserEvent.deleteUser(user)),
            );
          },
        );
      },
    );
  }
}
