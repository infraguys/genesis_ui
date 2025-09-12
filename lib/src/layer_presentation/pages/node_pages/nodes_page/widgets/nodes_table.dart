import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_label.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class NodesTable extends StatelessWidget {
  const NodesTable({
    required this.nodes,
    super.key,
    this.allowMultiSelect = true,
  });

  final List<Node> nodes;
  final bool allowMultiSelect;

  @override
  Widget build(BuildContext context) {
    return AppTable(
      columnSpans: [
        TableSpan(extent: FixedSpanExtent(40.0)),
        TableSpan(extent: FractionalTableSpanExtent(2 / 10)),
        TableSpan(extent: FractionalTableSpanExtent(2 / 10)),
        TableSpan(extent: FractionalTableSpanExtent(4 / 10)),
        TableSpan(extent: FractionalTableSpanExtent(2 / 10)),
        TableSpan(extent: FixedSpanExtent(56.0)),
      ],
      headerCells: [
        Checkbox(
          tristate: true,
          onChanged: (_) {
            if (allowMultiSelect) {
              // context.read<ProjectsSelectionBloc>().add(ProjectsSelectionEvent.toggleAll(extensions));
            }
          },
          value: switch (0) {
            0 => false,
            final len when len == nodes.length => true,
            _ => null,
          },
        ),
        Text('Nodes'.hardcoded, style: TextStyle(color: Colors.white)),
        Text(context.$.status, style: TextStyle(color: Colors.white)),
        Text(context.$.uuid, style: TextStyle(color: Colors.white)),
        Text(context.$.createdAt, style: TextStyle(color: Colors.white)),
      ],
      length: nodes.length,
      cellsBuilder: (index) {
        final node = nodes[index];
        return [
          Checkbox(
            value: false,
            onChanged: (_) {
              // if (!allowMultiSelect) {
              //   context.read<ProjectsSelectionBloc>().add(ProjectsSelectionEvent.clear());
              // }
              // context.read<ProjectsSelectionBloc>().add(ProjectsSelectionEvent.toggle(project));
            },
          ),
          Text(node.name, style: TextStyle(color: Colors.white)),
          // todo: поменять статус
          StatusLabel(status: Status.active), // Assuming all projects are active for simplicity
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: SelectableText(
                    node.uuid.value,
                    style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
                  ),
                ),
                WidgetSpan(child: const SizedBox(width: 8)),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: node.uuid.value));
                      final snack = AppSnackBar.success('Скопировано в буфер обмена: ${node.uuid}');
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('dd.MM.yyyy HH:mm').format(node.createdAt),
            style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
          ),
          SizedBox.shrink(),
          // ProjectsActionPopupMenuButton(project: project),
        ];
      },
      onTap: (index) {
        // final project = extensions[index];
        // context.goNamed(
        //   AppRoutes.project.name,
        //   pathParameters: {'uuid': project.uuid.value},
        //   extra: project,
        // );
      },
    );
  }
}
