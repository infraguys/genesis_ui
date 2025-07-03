import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/auth/domain/entity/user.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class UsersListDetails extends StatelessWidget {
  const UsersListDetails({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return ExpansionTile(
      title: Row(
        children: [
          SizedBox(width: 250, child: Text(user.username)),
          Text(user.status.name),
        ],
      ),
      leading: Icon(Icons.play_arrow, color: Colors.green),
      trailing: IconButton(
        onPressed: () {
          context.goNamed(AppRoutes.user.name, pathParameters: {'uuid': user.uuid});
        },
        icon: Icon(Icons.more_vert),
      ),
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
