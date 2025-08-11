import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/widgets/roles_list_item.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_table.dart';

class RolesTable extends StatelessWidget {
  const RolesTable({required this.roles, super.key});

  final List<Role> roles;

  @override
  Widget build(BuildContext context) {
    return AppTable(
      entities: roles,
      item: RolesListItem(),
      title: Row(
        spacing: 48,
        children: [
          Expanded(flex: 2, child: Text(context.$.role(1))),
          Expanded(child: Text(context.$.status)),
          Expanded(flex: 4, child: Text(context.$.uuid)),
          Spacer(flex: 2),
        ],
      ),
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
    );
  }
}
