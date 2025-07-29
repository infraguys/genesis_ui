import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/common/shared_widgets/status_label.dart';
import 'package:genesis/src/features/users/presentation/widgets/users_actions_popup_menu_button.dart';

class UsersListItem extends StatelessWidget {
  const UsersListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<User>();

    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: ListTileThemeData(
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.zero,
          tileColor: Colors.transparent,
        ),
      ),
      child: ExpansionTile(
        title: Row(
          spacing: 48,
          children: [
            // SizedBox(width: 250, child: Text(user.username)),
            Expanded(flex: 2, child: Text(user.username)),
            Flexible(child: StatusLabel(status: user.status)),
            Expanded(flex: 3, child: Text(user.createdAt.toString())),
            Spacer(flex: 3),
          ],
        ),
        leading: Checkbox(value: true, onChanged: (_) {}),
        trailing: UsersActionsPopupMenuButton(user: user),
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: EdgeInsets.only(left: 50),
      ),
    );
  }
}
