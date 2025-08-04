import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/common/shared_entities/role.dart';
import 'package:genesis/src/features/common/shared_widgets/app_table.dart';
import 'package:genesis/src/features/role/presentation/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/features/role/presentation/widgets/roles_list_item.dart';

class RolesTable extends StatelessWidget {
  const RolesTable({required this.roles, super.key});

  final List<Role> roles;

  @override
  Widget build(BuildContext context) {
    return AppTable(
      entities: roles,
      item: RolesListItem(),
      headerLeading: BlocBuilder<RolesSelectionBloc, List<Role>>(
        builder: (context, state) {
          return Checkbox(
            value: switch (state.length) {
              0 => false,
              final len when len == roles.length => true,
              _ => null,
            },
            tristate: true,
            onChanged: (val) {
              context.read<RolesSelectionBloc>().add(RolesSelectionEvent.selectAll(roles));
            },
          );
        },
      ),

      title: Row(
        spacing: 48,
        children: [
          Expanded(flex: 2, child: Text(context.$.role(1))),
          Expanded(child: Text(context.$.status)),
          Expanded(flex: 4, child: Text('Created At')),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
