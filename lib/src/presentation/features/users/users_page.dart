import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/presentation/features/users/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/presentation/features/users/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/presentation/features/users/widgets/users_list_details.dart';
import 'package:provider/provider.dart';

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
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is DeleteSuccessUserState) {
          context.read<UsersBloc>().add(UsersEvent.getUsers());
        }
      },
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, usersState) {
          if (usersState is! SuccessUsersState) {
            return Center(child: CupertinoActivityIndicator());
          }
          return Center(
            child: ListView.separated(
              itemCount: usersState.users.length,
              itemBuilder: (context, index) {
                final currentUser = usersState.users[index];
                return Provider.value(
                  value: currentUser,
                  child: UsersListDetails(),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(color: Colors.white, indent: 100, endIndent: 100);
              },
            ),
          );
        },
      ),
    );
  }
}
