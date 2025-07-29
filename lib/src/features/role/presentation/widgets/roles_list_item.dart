import 'package:flutter/material.dart';
import 'package:genesis/src/features/common/shared_entities/role.dart';
import 'package:genesis/src/features/common/shared_widgets/status_label.dart';
import 'package:genesis/src/features/role/presentation/widgets/roles_action_popup_menu_button.dart';
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
            Expanded(flex: 2, child: Text(role.name)),
            Flexible(child: StatusLabel(status: role.status)),
            Expanded(flex: 4, child: Text(role.createdAt.toString())),
            Spacer(flex: 2),
          ],
        ),
        leading: Checkbox(value: true, onChanged: (_) {}),
        trailing: RolesActionPopupMenuButton(role: role),
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: EdgeInsets.only(left: 50),
      ),
    );
  }
}
