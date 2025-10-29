import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/user_pages/create_user_page/create_user_page.dart';
import 'package:genesis/src/layer_presentation/pages/user_pages/users_list_page/widgets/users_table.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirm_email_icon_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/create_icon_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/delete_elevated_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/delete_users_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/page_layout.dart';

part './widgets/confirm_email_btn.dart';

part './widgets/delete_user_btn.dart';

class _UserListView extends StatelessWidget {
  const _UserListView();

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      breadcrumbs: [
        BreadcrumbItem(text: context.$.users),
      ],
      buttons: [
        _DeleteUserButton(),
        _ConfirmEmailButton(),
        CreateIconButton(
          onPressed: () async {
            await showDialog<void>(
              context: context,
              builder: (context) => Dialog(child: CreateUserPage()),
            );
          },
        ),
      ],
      child: Expanded(
        child: BlocConsumer<UsersBloc, UsersState>(
          listenWhen: (_, current) => current.shouldListen,
          listener: (context, state) {
            final messenger = ScaffoldMessenger.of(context);

            switch (state) {
              case UsersDeletedState(:final users) when users.length == 1:
                context.read<UsersSelectionCubit>().onClear();
                final msg = switch (users.length) {
                  1 => context.$.msgUserDeleted(users.single.username),
                  _ => context.$.msgUsersDeleted(users.length),
                };
                messenger.showSnackBar(AppSnackBar.success(msg));

              case UsersPermissionFailureState(:final message):
                messenger.showSnackBar(AppSnackBar.failure(context.$.msgPermissionDenied(message)));
              default:
            }
          },
          buildWhen: (_, current) => current is UsersLoadingState || current is UsersLoadedState,
          builder: (_, state) {
            return switch (state) {
              _ when state is! UsersLoadedState => AppProgressIndicator(),
              _ => UsersTable(users: state.users),
            };
          },
        ),
      ),
    );
  }
}

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UsersSelectionCubit(),
      child: _UserListView(),
    );
  }
}
