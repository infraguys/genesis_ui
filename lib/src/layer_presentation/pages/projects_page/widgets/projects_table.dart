import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_selection_bloc/projects_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/widgets/projects_list_item.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_table.dart';

class ProjectsTable extends StatelessWidget {
  const ProjectsTable({required this.projects, super.key});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return AppTable<Project>(
      entities: projects,
      item: ProjectsListItem(),
      title: Row(
        spacing: 48,
        children: [
          Expanded(flex: 2, child: Text(context.$.project)),
          Expanded(child: Text(context.$.status)),
          Expanded(flex: 4, child: Text(context.$.uuid)),
          Spacer(flex: 2),
        ],
      ),
      headerLeading: BlocBuilder<ProjectsSelectionBloc, List<Project>>(
        builder: (context, state) {
          return Checkbox(
            value: switch (state.length) {
              0 => false,
              final len when len == projects.length => true,
              _ => null,
            },
            tristate: true,
            onChanged: (val) {
              context.read<ProjectsSelectionBloc>().add(ProjectsSelectionEvent.selectAll(projects));
            },
          );
        },
      ),
    );
  }
}
