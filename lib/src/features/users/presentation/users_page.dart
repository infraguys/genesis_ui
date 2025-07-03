import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/features/users/presentation/widgets/users_list_details.dart';

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
              return UsersListDetails(user: currentUser);
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
