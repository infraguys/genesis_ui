import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/layer_domain/entities/permission.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_selection_bloc/permissions_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_label.dart';

class PermissionListItem extends StatelessWidget {
  const PermissionListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final permission = context.read<Permission>();
    final textTheme = TextTheme.of(context);
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        listTileTheme: theme.listTileTheme.copyWith(
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.zero,
          tileColor: Colors.transparent,
        ),
      ),
      child: ExpansionTile(
        title: Row(
          spacing: 48,
          children: [
            Expanded(flex: 2, child: Text(permission.name)),
            // TODO:  проверить статус
            Flexible(child: StatusLabel(status: Status.active)), // Assuming all permissions are active
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('...${permission.uuid.split('-').last}'),
                  IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: permission.uuid));
                      final snack = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Скопировано в буфер обмена: ${permission.uuid}'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  ),
                ],
              ),
            ),
            Spacer(flex: 4),
          ],
        ),
        leading: BlocBuilder<PermissionsSelectionBloc, List<Permission>>(
          builder: (context, state) {
            return Checkbox(
              value: state.contains(permission),
              onChanged: (val) {
                context.read<PermissionsSelectionBloc>().add(PermissionsSelectionEvent.togglePermission(permission));
              },
            );
          },
        ),
        // trailing: UsersActionsPopupMenuButton(),
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
                  Text(permission.description, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                ],
              ),
              TableRow(
                children: [
                  Text(context.$.uuid, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                  SelectableText(permission.uuid, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                ],
              ),
              TableRow(
                children: [
                  Text(context.$.createdAt, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                  SelectableText(
                    permission.createdAt.toIso8601String(),
                    style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white,
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(context.$.updatedAt, style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white),
                  SelectableText(
                    permission.updatedAt.toIso8601String(),
                    style: textTheme.bodyMedium!.copyWith(height: 1.8) + Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
