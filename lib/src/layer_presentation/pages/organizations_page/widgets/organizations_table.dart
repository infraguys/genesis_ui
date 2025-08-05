import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/blocs/organizations_selection_bloc/organizations_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/widgets/organizations_list_item.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_table.dart';

class OrganizationsTable extends StatelessWidget {
  const OrganizationsTable({required this.organizations, super.key});

  final List<Organization> organizations;

  @override
  Widget build(BuildContext context) {
    return AppTable<Organization>(
      entities: organizations,
      item: OrganizationsListItem(),
      title: Row(
        spacing: 48,
        children: [
          Expanded(flex: 2, child: Text(context.$.name)),
          Expanded(child: Text(context.$.status)),
          Expanded(flex: 4, child: Text(context.$.uuid)),
          Spacer(flex: 2),
        ],
      ),
      headerLeading: BlocBuilder<OrganizationsSelectionBloc, List<Organization>>(
        builder: (context, state) {
          return Checkbox(
            value: switch (state.length) {
              0 => false,
              final len when len == organizations.length => true,
              _ => null,
            },
            tristate: true,
            onChanged: (val) {
              context.read<OrganizationsSelectionBloc>().add(OrganizationsSelectionEvent.selectAll(organizations));
            },
          );
        },
      ),
    );
  }
}
