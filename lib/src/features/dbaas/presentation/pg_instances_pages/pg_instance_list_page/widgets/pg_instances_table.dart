import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_widgets/pg_instance_status_widget.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class PgInstancesTable extends StatelessWidget {
  const PgInstancesTable({
    required this.instances,
    this.allowMultiSelect = true,
    super.key,
  });

  final List<PgInstance> instances;
  final bool allowMultiSelect;

  @override
  Widget build(BuildContext context) {
    return AppTable(
      length: instances.length,
      columnSpans: [
        TableSpan(extent: FixedSpanExtent(40.0)),
        TableSpan(extent: FractionalSpanExtent(2 / 10)),
        TableSpan(extent: FractionalSpanExtent(2 / 10)),
        TableSpan(extent: FractionalSpanExtent(4 / 10)),
        TableSpan(extent: FractionalSpanExtent(2 / 10)),
        TableSpan(extent: FixedSpanExtent(56.0)),
      ],
      headerCells: [
        Checkbox(
          tristate: true,
          value: true,
          onChanged: (_) {
            // if (allowMultiSelect) {
            //   // context.read<UsersSelectionBloc>().add(UsersSelectionEvent.toggleAll(users));
            // }
          },
          // value: switch (state.length) {
          //   0 => false,
          //   final len when len == users.length => true,
          //   _ => null,
          // },
        ),
        Text(context.$.user, style: TextStyle(color: Colors.white)),
        Text(context.$.status, style: TextStyle(color: Colors.white)),
        Text(context.$.uuid, style: TextStyle(color: Colors.white)),
        Text(context.$.createdAt, style: TextStyle(color: Colors.white)),
      ],
      cellsBuilder: (index) {
        final instance = instances[index];
        return [
          Checkbox(
            // value: state.contains(instance),
            value: true,
            onChanged: (_) {
              // if (!allowMultiSelect) {
              //   context.read<UsersSelectionBloc>().add(UsersSelectionEvent.clear());
              // }
              // context.read<UsersSelectionBloc>().add(UsersSelectionEvent.toggle(instance));
            },
          ),
          Text(instance.name, style: TextStyle(color: Colors.white)),
          PgInstanceStatusWidget(status: instance.status),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: SelectableText(
                    instance.id.raw,
                    style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
                  ),
                ),
                WidgetSpan(child: const SizedBox(width: 8)),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: instance.id.raw));
                      final snack = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(context.$.msgCopiedToClipboard(instance.id.raw)),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('dd.MM.yyyy HH:mm').format(instance.createdAt),
            style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
          ),
          SizedBox.shrink(),
        ];
      },
      onTap: (index) {
        final instance = instances[index];
        context.goNamed(
          AppRoutes.instance.name,
          pathParameters: {'id': instance.id.raw},
        );
      },
    );
  }
}
