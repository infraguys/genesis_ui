import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users/users_page/widgets/delete_users_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/users/users_page/widgets/users_create_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/users/users_page/widgets/users_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/search_input.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            SearchInput(),
            Spacer(),
            DeleteUsersIconButton(),
            // UsersConfirmEmailIconButton(),
            UsersCreateIconButton(),
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
    );
  }
}
