import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/delete_user_params.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_user_dialog.dart';

class DeleteUserIconButton extends StatelessWidget {
  const DeleteUserIconButton({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return DeleteIconButton(
      onPressed: () async {
        await showDialog<void>(
          context: context,
          builder: (context) => DeleteUserDialog(
            users: List.generate(1, (_) => user),
            onDelete: () {
              context.read<UserBloc>().add(
                UserEvent.deleteUser(DeleteUserParams(user.uuid)),
              );
            },
          ),
        );
      },
    );
  }
}
