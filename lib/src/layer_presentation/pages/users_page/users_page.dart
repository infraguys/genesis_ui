import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/user_page/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/users_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';

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
          // TODO: Добавить название страницы
          Breadcrumbs(
            items: [
              BreadcrumbItem(text: 'users'),
            ],
          ),
          // Text(context.$.users, ),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<UsersBloc, UsersState>(
              builder: (context, state) {
                if (state is! UsersLoadedState) {
                  return AppProgressIndicator();
                }
                return UsersTable(users: state.users);
              },
            ),
          ),
        ],
      ),
    );
  }
}
