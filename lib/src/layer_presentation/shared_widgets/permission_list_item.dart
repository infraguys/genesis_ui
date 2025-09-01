import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/permission.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_selection_bloc/permissions_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_label.dart';

class PermissionListItem extends StatelessWidget {
  const PermissionListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final permission = context.read<Permission>();
    return ListTile(
      title: Row(
        spacing: 48,
        children: [
          Expanded(flex: 2, child: Text(permission.name)),
          // TODO:  проверить статус
          Flexible(child: StatusLabel(status: Status.active)),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('...${permission.uuid.value.split('-').last}'),
                IconButton(
                  icon: Icon(Icons.copy, color: Colors.white, size: 18),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: permission.uuid.value));
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
              context.read<PermissionsSelectionBloc>().add(PermissionsSelectionEvent.toggle(permission));
            },
          );
        },
      ),
    );
  }
}
