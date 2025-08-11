import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_label.dart';

class RolesListItem extends StatelessWidget {
  const RolesListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final role = context.read<Role>();
    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme:
            Theme.of(
              context,
            ).listTileTheme.copyWith(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              tileColor: Colors.transparent,
            ),
      ),
      child: ListTile(
        title: Row(
          spacing: 48,
          children: [
            Expanded(flex: 2, child: Text(role.name)),
            Flexible(child: StatusLabel(status: role.status)),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(role.uuid),
                  IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: role.uuid));
                      final snack = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Скопировано в буфер обмена: ${role.uuid}'),
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
        leading: BlocBuilder<RolesSelectionBloc, List<Role>>(
          builder: (context, state) {
            return Checkbox(
              value: state.contains(role),
              onChanged: (_) {
                context.read<RolesSelectionBloc>().add(RolesSelectionEvent.toggleRole(role));
              },
            );
          },
        ),
        // trailing: RolesActionPopupMenuButton(role: role),
        // TODO: Чуть позже удалить
        // expandedAlignment: Alignment.centerLeft,
        // childrenPadding: EdgeInsets.only(left: 50),
      ),
    );
  }
}
