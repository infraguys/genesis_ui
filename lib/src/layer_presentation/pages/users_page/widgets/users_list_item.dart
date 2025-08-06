import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/users_actions_popup_menu_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_label.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

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
      child: ListTile(
        title: Row(
          spacing: 48,
          children: [
            Expanded(flex: 2, child: Text(user.username)),
            Flexible(child: StatusLabel(status: user.status)),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(user.uuid),
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
            Spacer(flex: 2),
          ],
        ),
        leading: BlocBuilder<UsersSelectionBloc, List<User>>(
          builder: (context, state) {
            return Checkbox(
              value: state.contains(user),
              onChanged: (val) {
                context.read<UsersSelectionBloc>().add(UsersSelectionEvent.toggleUser(user));
              },
            );
          },
        ),
        trailing: UsersActionsPopupMenuButton(user: user),
        // todo: в будущем удалить
        // expandedAlignment: Alignment.centerLeft,
        // childrenPadding: EdgeInsets.only(left: 50),
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
        onTap: () {
          final user = context.read<User>();
          context.goNamed(
            AppRoutes.user.name,
            pathParameters: {'uuid': user.uuid},
            extra: (extra: user, breadcrumbs: [user.username]),
          );
        },
      ),
    );
  }
}
