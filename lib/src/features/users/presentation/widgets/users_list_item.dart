import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/common/shared_widgets/status_label.dart';
import 'package:genesis/src/features/users/presentation/widgets/users_actions_popup_menu_button.dart';

class UsersListItem extends StatelessWidget {
  const UsersListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<User>();
    final textTheme = TextTheme.of(context);

    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: Theme.of(context).listTileTheme.copyWith(
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.zero,
          tileColor: Colors.transparent,
        ),
      ),
      child: ExpansionTile(
        title: Row(
          spacing: 48,
          children: [
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
        children: [
          Table(
            columnWidths: const {
              0: FixedColumnWidth(250),
              1: FlexColumnWidth(),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(),
                children: [
                  Text(context.$.description, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                  Text(user.description, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                ],
              ),
              TableRow(
                children: [
                  Text(context.$.firstName, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                  SelectableText(user.firstName, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                ],
              ),
              TableRow(
                children: [
                  Text(context.$.lastName, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                  SelectableText(user.lastName, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                ],
              ),
              TableRow(
                children: [
                  Text(context.$.email, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                  SelectableText(user.email, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                ],
              ),
              TableRow(
                children: [
                  Text(context.$.uuid, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                  SelectableText(user.uuid, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
