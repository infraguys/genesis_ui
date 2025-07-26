import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/common/shared_widgets/status_label.dart';
import 'package:genesis/src/features/users/presentation/widgets/users_actions_popup_menu_button.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class UsersListDetails extends StatelessWidget {
  const UsersListDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<User>();
    final textTheme = TextTheme.of(context);

    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: ListTileThemeData(
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.zero,
          tileColor: Colors.transparent,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ExpansionTile(
            title: Row(
              spacing: 48,
              children: [
                // SizedBox(width: 250, child: Text(user.username)),
                Expanded(flex: 2, child: Text(user.username)),
                Flexible(child: StatusLabel(status: user.status)),
                Expanded(flex: 4, child: Text(user.createdAt.toString())),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    context.goNamed(AppRoutes.user.name, pathParameters: {'uuid': user.uuid}, extra: user);
                  },
                  child: Icon(Icons.remove_red_eye),
                ),
              ],
            ),
            leading: Checkbox(value: true, onChanged: (_) {}),
            trailing: UsersActionsPopupMenuButton(),
            expandedAlignment: Alignment.centerLeft,
            childrenPadding: EdgeInsets.only(left: 50),
            // children: [
            //   Table(
            //     columnWidths: const {
            //       0: FixedColumnWidth(250),
            //       1: FlexColumnWidth(),
            //     },
            //     children: [
            //       TableRow(
            //         decoration: BoxDecoration(),
            //         children: [
            //           Text(context.$.description, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
            //           Text(user.description, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
            //         ],
            //       ),
            //       TableRow(
            //         children: [
            //           Text(context.$.firstName, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
            //           SelectableText(user.firstName, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
            //         ],
            //       ),
            //       TableRow(
            //         children: [
            //           Text(context.$.lastName, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
            //           SelectableText(user.lastName, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
            //         ],
            //       ),
            //       TableRow(
            //         children: [
            //           Text(context.$.email, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
            //           SelectableText(user.email, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
            //         ],
            //       ),
            //       TableRow(
            //         children: [
            //           Text(context.$.uuid, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
            //           SelectableText(user.uuid, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
            //         ],
            //       ),
            //     ],
            //   ),
            // ],
          );
        },
      ),
    );
  }
}
