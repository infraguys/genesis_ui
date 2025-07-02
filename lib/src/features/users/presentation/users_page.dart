import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    context.read<UsersBloc>().add(UsersEvent.getUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, usersState) {
        if (usersState is! SuccessUsersState) {
          return Center(child: CupertinoActivityIndicator());
        }
        return Center(
          child: ListView.separated(
            itemCount: usersState.users.length,
            itemBuilder: (context, index) {
              final currentUser = usersState.users[index];
              return ExpansionTile(
                title: Row(
                  spacing: 100,
                  children: [
                    Text(currentUser.firstName),
                    Text(currentUser.status.name),
                  ],
                ),
                leading: Icon(Icons.play_arrow, color: Colors.green),
                trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                expandedAlignment: Alignment.centerLeft,
                children: [
                  Row(
                    spacing: 100,
                    children: [
                      Text('Description'.hardcoded),
                      Text(currentUser.description),
                    ],
                  ),
                  Row(
                    spacing: 100,
                    children: [
                      Text('First name'.hardcoded),
                      Text(currentUser.firstName),
                    ],
                  ),
                  Row(
                    spacing: 100,
                    children: [
                      Text('Last name'.hardcoded),
                      Text(currentUser.lastName),
                    ],
                  ),
                  Row(
                    spacing: 100,
                    children: [
                      Text('email'.hardcoded),
                      Text(currentUser.email),
                    ],
                  ),
                  Row(
                    spacing: 100,
                    children: [
                      Text('Created at'.hardcoded),
                      Text(currentUser.createdAt.toString()),
                    ],
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return Divider(color: Colors.white, indent: 100, endIndent: 100);
            },
          ),
        );
      },
    );
  }
}
