import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/users/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/features/users/presentation/widgets/users_list_details.dart';
import 'package:provider/provider.dart';

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
        if (state is UserStateDeleteSuccess || state is UserStateUpdateSuccess) {
          context.read<UsersBloc>().add(UsersEvent.getUsers());
        }
      },
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, usersState) {
          if (usersState is! UsersLoadedState) {
            return Center(child: CupertinoActivityIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.$.users, style: TextStyle(color: Colors.white54, fontSize: 12)),
              const SizedBox(height: 24),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
                ),
                contentPadding: EdgeInsets.zero,
                leading: Checkbox(value: true, onChanged: (_) {}),
                trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                title: Row(
                  spacing: 48,
                  children: [
                    Expanded(flex: 2, child: Text('Username')),
                    Expanded(child: Text('Status')),
                    Expanded(flex: 4, child: Text('Created At')),
                    Spacer(),
                    Visibility(
                      visible: false,
                      maintainSize: true,
                      maintainState: true,
                      maintainAnimation: true,
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.remove_red_eye),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: usersState.users.length,
                  itemBuilder: (context, index) {
                    final currentUser = usersState.users[index];
                    return Provider.value(
                      value: currentUser,
                      child: UsersListDetails(),
                    );
                  },
                  separatorBuilder: (_, _) => Divider(height: 0),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
