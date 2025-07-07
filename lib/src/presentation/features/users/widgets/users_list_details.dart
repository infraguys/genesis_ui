import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/domain/entities/user.dart';
import 'package:genesis/src/presentation/features/users/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/presentation/routing/app_router.dart';
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
      leading: Icon(Icons.play_arrow, color: Colors.green),
      trailing: PopupMenuButton<int>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        useRootNavigator: true,
        itemBuilder: (context) {
          return [
            PopupMenuItem(child: Text('Подтвердить email'.hardcoded)),
            PopupMenuItem(child: Text('Сменить пароль'.hardcoded)),
            PopupMenuItem(child: Text('Сменить email'.hardcoded)),
            PopupMenuItem(child: Text('Блокировать'.hardcoded)),
            PopupMenuItem(
              labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Colors.red)),
              child: Text('Удалить'.hardcoded),
              onTap: () {
                context.read<UsersBloc>().add(UsersEvent.deleteUser(user.uuid));
              },
            ),
          ];
        },
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
