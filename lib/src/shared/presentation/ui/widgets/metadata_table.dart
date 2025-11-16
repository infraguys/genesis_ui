import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:intl/intl.dart';

class MetadataTable extends StatelessWidget {
  const MetadataTable({
    required this.statusWidget,
    required this.createdAt,
    required this.updatedAt,
    this.verificationStatusWidget,
    super.key,
  });

  final Widget statusWidget;
  final Widget? verificationStatusWidget;
  final DateTime createdAt;
  final DateTime updatedAt;

  String getFormattedDate(DateTime date) {
    return DateFormat('dd.MM.yyyy HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: FixedColumnWidth(140),
      children: [
        TableRow(
          children: [
            Padding(padding: const .all(8.0), child: Text(context.$.status)),
            Padding(padding: const .all(8.0), child: statusWidget),
          ],
        ),
        if (verificationStatusWidget != null)
          TableRow(
            children: [
              Padding(padding: const .all(8.0), child: Text(context.$.verification)),
              Padding(padding: const .all(8.0), child: verificationStatusWidget!),
            ],
          ),
        TableRow(
          children: [
            Padding(padding: const .all(8.0), child: Text(context.$.createdAt)),
            Padding(padding: const .all(8.0), child: Text(getFormattedDate(createdAt))),
          ],
        ),
        TableRow(
          children: [
            Padding(padding: const .all(8.0), child: Text(context.$.updatedAt)),
            Padding(padding: const .all(8.0), child: Text(getFormattedDate(updatedAt))),
          ],
        ),
      ],
    );
  }
}
