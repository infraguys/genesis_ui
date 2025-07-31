import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/common/shared_widgets/app_table.dart';
import 'package:genesis/src/features/users/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/features/users/presentation/widgets/users_list_item.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        switch (state) {
          case UserStateDeleteSuccess():
          case UserStateUpdateSuccess():
            context.read<UsersBloc>().add(UsersEvent.getUsers());
          default:
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.$.users, style: TextStyle(color: Colors.white54, fontSize: 12)),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<UsersBloc, UsersState>(
              builder: (context, state) {
                if (state is! UsersLoadedState) {
                  return Center(child: CupertinoActivityIndicator());
                }
                return AppTable<User>(
                  entities: state.users,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
