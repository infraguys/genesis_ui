import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/users_actions_popup_menu_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_label.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/verified_label.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class UsersListItem extends StatelessWidget {
  const UsersListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<User>();

    return ListTile(
      title: Row(
        spacing: 48,
        children: [
          Expanded(flex: 2, child: SelectableText(user.username)),
          StatusLabel(status: user.status),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText(user.uuid),
                IconButton(
                  icon: Icon(Icons.copy, color: Colors.white, size: 18),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: user.uuid));
                    final snack = SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Скопировано в буфер обмена: ${user.uuid}'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snack);
                  },
                ),
              ],
            ),
          ),
          VerifiedLabel(isVerified: user.emailVerified),
        ],
      ),
      leading: BlocBuilder<UsersSelectionBloc, List<User>>(
        builder: (context, state) {
          return Checkbox(
            value: state.contains(user),
            onChanged: (_) {
              context.read<UsersSelectionBloc>().add(UsersSelectionEvent.toggleUser(user));
            },
          );
        },
      ),
      trailing: UsersActionsPopupMenuButton(user: user),
      onTap: () {
        final user = context.read<User>();
        context.goNamed(
          AppRoutes.user.name,
          pathParameters: {'uuid': user.uuid},
          extra: user,
        );
      },
    );
  }
}
