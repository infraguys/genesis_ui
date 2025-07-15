import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/users/presentation/widgets/users_actions_popup_menu_button.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class UsersListDetails extends StatelessWidget {
  const UsersListDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<User>();
    final textTheme = TextTheme.of(context);

    return ExpansionTile(
      title: Row(
        children: [
          SizedBox(width: 250, child: Text(user.username)),
          SizedBox(
            width: 250,
            child: Text(
              user.status.name,
              style: TextStyle(color: user.status == UserStatus.active ? Colors.green : Colors.red),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              context.goNamed(AppRoutes.user.name, pathParameters: {'uuid': user.uuid}, extra: user);
            },
            child: Icon(Icons.remove_red_eye),
          ),
        ],
      ),
      leading: Icon(CupertinoIcons.play_arrow_solid, color: Colors.green),
      trailing: UsersActionsPopupMenuButton(),
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
              children: [
                Text(context.$.description, style: textTheme.bodyMedium!.copyWith(height: 1.8)),
                Text(user.description, style: textTheme.bodyMedium!.copyWith(height: 1.8)),
              ],
            ),
            TableRow(
              children: [
                Text(context.$.firstName, style: textTheme.bodyMedium!.copyWith(height: 1.8)),
                Text(user.firstName, style: textTheme.bodyMedium!.copyWith(height: 1.8)),
              ],
            ),
            TableRow(
              children: [
                Text(context.$.lastName, style: textTheme.bodyMedium!.copyWith(height: 1.8)),
                Text(user.lastName, style: textTheme.bodyMedium!.copyWith(height: 1.8)),
              ],
            ),
            TableRow(
              children: [
                Text(context.$.email, style: textTheme.bodyMedium!.copyWith(height: 1.8)),
                Text(user.email, style: textTheme.bodyMedium!.copyWith(height: 1.8)),
              ],
            ),
            TableRow(
              children: [
                Text(context.$.uuid, style: textTheme.bodyMedium!.copyWith(height: 1.8)),
                Text(user.uuid, style: textTheme.bodyMedium!.copyWith(height: 1.8)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
