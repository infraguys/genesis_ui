import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_users_dialog.dart';

class DeleteUsersIconButton extends StatelessWidget {
  const DeleteUsersIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersSelectionBloc, List<User>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }
        return DeleteIconButton(
          onPressed: () async {
            await showDialog<void>(
              context: context,
              builder: (context) => DeleteUsersDialog(
                users: state,
                onDelete: () {
                  context.read<UsersBloc>().add(UsersEvent.deleteUsers(state));
                },
              ),
            );
          },
        );
      },
    );
  }
}
