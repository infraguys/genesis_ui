import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/permission.dart';
import 'package:genesis/src/layer_presentation/pages/role_page/blocs/permissions_selection_bloc/permissions_selection_bloc%20.dart';
import 'package:genesis/src/layer_presentation/pages/role_page/widgets/permission_list_item.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_table.dart';

class PermissionsTable extends StatelessWidget {
  const PermissionsTable({required this.permissions, super.key});

  final List<Permission> permissions;

  @override
  Widget build(BuildContext context) {
    return AppTable<Permission>(
      entities: permissions,
      headerLeading: BlocBuilder<PermissionsSelectionBloc, List<Permission>>(
        builder: (context, state) {
          return Checkbox(
            value: switch (state.length) {
              0 => false,
              final len when len == permissions.length => true,
              _ => null,
            },
            tristate: true,
            onChanged: (val) {
              context.read<PermissionsSelectionBloc>().add(PermissionsSelectionEvent.toggleAll(permissions));
            },
          );
        },
      ),
      item: PermissionListItem(),
      title: Row(
        spacing: 48,
        children: [
          Expanded(flex: 2, child: Text(context.$.name)),
          Expanded(child: Text(context.$.status)),
          Expanded(flex: 4, child: Text(context.$.uuid)),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
