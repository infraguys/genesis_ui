import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_presentation/pages/user_page/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/users_bloc_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/users_confirm_email_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/users_create_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/users_delete_icon_button.dart';
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
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            switch (state) {
              case UserStateDeleteSuccess():
              case UserStateUpdateSuccess():
                context.read<UsersBloc>().add(UsersEvent.getUsers());
              default:
            }
          },
        ),
        BlocListener<UsersBloc, UsersState>(
          listener: (context, state) {
            if (state is UsersLoadedState) {
              context.read<UsersSelectionBloc>().add(UsersSelectionEvent.clearSelection());
            }
          },
        ),
      ],
      child: Column(
        spacing: 24.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Breadcrumbs(
            items: [
              BreadcrumbItem(text: context.$.users),
            ],
          ),
          // Text(context.$.users, ),
          Row(
            spacing: 4.0,
            children: [
              Spacer(),
              UsersDeleteIconButton(),
              UsersBlockIconButton(),
              UsersConfirmEmailIconButton(),
              UsersCreateIconButton(),
            ],
          ),
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
