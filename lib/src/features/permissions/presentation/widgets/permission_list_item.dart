import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/permission.dart';
import 'package:genesis/src/features/common/shared_entities/status.dart';
import 'package:genesis/src/features/common/shared_widgets/status_label.dart';

class PermissionListItem extends StatelessWidget {
  const PermissionListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final permission = context.read<Permission>();

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
            Expanded(flex: 2, child: Text(permission.name)),
            // TODO:  проверить статус
            Flexible(child: StatusLabel(status: Status.active)), // Assuming all permissions are active
            Expanded(flex: 4, child: Text(permission.createdAt.toString())),
            Spacer(flex: 2),
          ],
        ),
        leading: Checkbox(value: true, onChanged: (_) {}),
        // trailing: UsersActionsPopupMenuButton(),
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: EdgeInsets.only(left: 50),
      ),
    );
  }
}
