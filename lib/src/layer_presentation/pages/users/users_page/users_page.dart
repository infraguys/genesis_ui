import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users/users_page/widgets/delete_users_elevated_button.dart';
import 'package:genesis/src/layer_presentation/pages/users/users_page/widgets/users_confirm_email_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/users/users_page/widgets/users_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/create_icon_button.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class _UsersView extends StatelessWidget {
  const _UsersView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listenWhen: (_, current) => current is UsersDeletedState,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case UsersDeletedState(:final users) when users.length == 1:
            messenger.showSnackBar(AppSnackBar.success(context.$.msgUserDeleted(users.single.username)));
          case UsersDeletedState(:final users) when users.length > 1:
            messenger.showSnackBar(AppSnackBar.success(context.$.msgUsersDeleted(users.length)));
          default:
        }
      },
      child: Column(
        spacing: 24.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Breadcrumbs(
            items: [
              BreadcrumbItem(text: context.$.users),
            ],
          ),
          ButtonsBar.withoutLeftSpacer(
            children: [
              // SearchInput(),
              Spacer(),
              DeleteUsersElevatedButton(),
              UsersConfirmEmailElevatedButton(),
              CreateIconButton(onPressed: () => context.goNamed(AppRoutes.createUser.name)),
            ],
          ),
          Expanded(
            child: BlocConsumer<UsersBloc, UsersState>(
              listenWhen: (_, current) => current is UsersLoadedState,
              listener: (context, _) {
                context.read<UsersSelectionBloc>().add(UsersSelectionEvent.clear());
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

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UsersSelectionBloc(),
      child: _UsersView(),
    );
  }
}
