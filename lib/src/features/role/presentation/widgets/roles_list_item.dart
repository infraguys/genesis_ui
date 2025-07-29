import 'package:flutter/material.dart';
import 'package:genesis/src/features/common/shared_entities/role.dart';
import 'package:genesis/src/features/common/shared_widgets/status_label.dart';
import 'package:provider/provider.dart';

class RolesListItem extends StatelessWidget {
  const RolesListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final role = context.read<Role>();
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
            // SizedBox(width: 250, child: Text(role.name)),
            Expanded(flex: 2, child: Text(role.name)),
            Flexible(child: StatusLabel(status: role.status)),
            Expanded(flex: 4, child: Text(role.createdAt.toString())),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.remove_red_eye),
            ),
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
