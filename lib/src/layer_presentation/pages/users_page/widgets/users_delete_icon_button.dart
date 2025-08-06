import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_icon_button.dart';

class UsersDeleteIconButton extends StatelessWidget {
  const UsersDeleteIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersSelectionBloc, List<User>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }
        return DeleteIconButton(
          onPressed: () {
            final userUuids = state.map((user) => user.uuid).toList();
            context.read<UsersBloc>().add(UsersEvent.deleteUsers(userUuids));
          },
        );
      },
    );
  }
}
