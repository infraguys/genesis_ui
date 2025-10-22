import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/user_pages/users_list_page/widgets/users_table.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/confirm_email_icon_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/create_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_users_dialog.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

part './widgets/confirm_email_btn.dart';

part './widgets/delete_user_btn.dart';

class _UserListView extends StatelessWidget {
  const _UserListView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listenWhen: (_, current) => current.shouldListen,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case UsersDeletedState(:final users) when users.length == 1:
            messenger.showSnackBar(AppSnackBar.success(context.$.msgUserDeleted(users.single.username)));
          case UsersDeletedState(:final users) when users.length > 1:
            messenger.showSnackBar(AppSnackBar.success(context.$.msgUsersDeleted(users.length)));

          case UsersPermissionFailureState(:final message):
            messenger.showSnackBar(AppSnackBar.failure(context.$.msgPermissionDenied(message)));
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
          ButtonsBar(
            children: [
              _DeleteUserButton(),
              _ConfirmEmailButton(),
              CreateIconButton(onPressed: () => context.goNamed(AppRoutes.createUser.name)),
            ],
          ),
          Expanded(
            child: BlocBuilder<UsersBloc, UsersState>(
              buildWhen: (_, current) => current is UsersLoadingState || current is UsersLoadedState,
              builder: (_, state) {
                return switch (state) {
                  UsersLoadedState(:final users) => UsersTable(users: users),
                  _ => AppProgressIndicator(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UsersSelectionBloc(),
      child: _UserListView(),
    );
  }
}
