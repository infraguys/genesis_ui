import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/users_bloc_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/users_confirm_email_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/users_create_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/users_delete_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/users_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            switch (state) {
              case UserStateSuccess():
                context.read<UsersBloc>().add(UsersEvent.getUsers());
              default:
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
          ButtonsBar(
            children: [
              UsersDeleteIconButton(),
              UsersBlockIconButton(),
              UsersConfirmEmailIconButton(),
              UsersCreateIconButton(),
            ],
          ),
          Expanded(
            child: BlocConsumer<UsersBloc, UsersState>(
              listenWhen: (_, current) => current is UsersLoadedState,
              listener: (context, _) {
                context.read<UsersSelectionBloc>().add(UsersSelectionEvent.clearSelection());
              },
              builder: (_, state) => switch (state) {
                UsersLoadedState(:final users) => UsersTable(users: users),
                _ => AppProgressIndicator(),
              },
            ),
          ),
        ],
      ),
    );
  }
}
