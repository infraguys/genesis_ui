import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_selection_bloc/projects_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_label.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class ProjectsTable extends StatelessWidget {
  const ProjectsTable({required this.projects, super.key});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return AppTable(
      columnSpans: [
        TableSpan(extent: FractionalTableSpanExtent(2 / 10)),
        TableSpan(extent: FractionalTableSpanExtent(2 / 10)),
        TableSpan(extent: FractionalTableSpanExtent(4 / 10)),
        TableSpan(extent: FractionalTableSpanExtent(2 / 10)),
      ],
      headerCells: [
        BlocBuilder<ProjectsSelectionBloc, List<Project>>(
          builder: (context, state) {
            return Checkbox(
              tristate: true,
              onChanged: (_) => context.read<ProjectsSelectionBloc>().add(
                ProjectsSelectionEvent.toggleAll(projects),
              ),
              value: switch (state.length) {
                0 => false,
                final len when len == projects.length => true,
                _ => null,
              },
            );
          },
        ),
        Text(context.$.project, style: TextStyle(color: Colors.white)),
        Text(context.$.status, style: TextStyle(color: Colors.white)),
        Text(context.$.uuid, style: TextStyle(color: Colors.white)),
        Text(context.$.createdAt, style: TextStyle(color: Colors.white)),
      ],
      length: projects.length,
      cellsBuilder: (index) {
        final project = projects[index];
        return [
          BlocBuilder<ProjectsSelectionBloc, List<Project>>(
            builder: (context, state) {
              return Checkbox(
                value: state.contains(project),
                onChanged: (_) => context.read<ProjectsSelectionBloc>().add(
                  ProjectsSelectionEvent.toggle(project),
                ),
              );
            },
          ),
          Text(project.name, style: TextStyle(color: Colors.white)),
          // todo: поменять статус
          StatusLabel(status: Status.active), // Assuming all projects are active for simplicity
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: SelectableText(
                    project.uuid,
                    style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
                  ),
                ),
                WidgetSpan(child: const SizedBox(width: 8)),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: project.uuid));
                      final snack = AppSnackBar.success('Скопировано в буфер обмена: ${project.uuid}');
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('dd.MM.yyyy HH:mm').format(project.createdAt),
            style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
          ),
        ];
      },
      onTap: (index) {
        final project = projects[index];
        context.goNamed(
          AppRoutes.projects.name,
          pathParameters: {'uuid': project.uuid},
          extra: project,
        );
      },
    );
    // return AppTable<Project>(
    //   entities: projects,
    //   item: ProjectsListItem(),
    //   title: Row(
    //     spacing: 48,
    //     children: [
    //       Expanded(flex: 2, child: Text(context.$.project)),
    //       Expanded(child: Text(context.$.status)),
    //       Expanded(flex: 4, child: Text(context.$.uuid)),
    //       Spacer(flex: 2),
    //     ],
    //   ),
    //   headerLeading: BlocBuilder<ProjectsSelectionBloc, List<Project>>(
    //     builder: (context, state) {
    //       return Checkbox(
    //         value: switch (state.length) {
    //           0 => false,
    //           final len when len == projects.length => true,
    //           _ => null,
    //         },
    //         tristate: true,
    //         onChanged: (val) {
    //           context.read<ProjectsSelectionBloc>().add(ProjectsSelectionEvent.toggleAll(projects));
    //         },
    //       );
    //     },
    //   ),
    // );
  }
}
