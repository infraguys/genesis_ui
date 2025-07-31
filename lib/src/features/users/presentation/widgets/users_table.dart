import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/common/shared_widgets/app_table.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/features/users/presentation/widgets/users_list_item.dart';

class UsersTable extends StatelessWidget {
  const UsersTable({required this.users, super.key});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return AppTable<User>(
      entities: users,
      headerLeading: BlocBuilder<UsersSelectionBloc, List<User>>(
        builder: (context, state) {
          return Checkbox(
            value: switch (state.length) {
              0 => false,
              final len when len == users.length => true,
              _ => null,
            },
            tristate: true,
            onChanged: (val) {
              context.read<UsersSelectionBloc>().add(UsersSelectionEvent.selectAll(users));
            },
          );
        },
      ),
      item: UsersListItem(),
      title: Row(
        spacing: 48,
        children: [
          Expanded(flex: 2, child: Text(context.$.username)),
          Expanded(child: Text(context.$.status)),
          Expanded(flex: 4, child: Text(context.$.uuid)),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
