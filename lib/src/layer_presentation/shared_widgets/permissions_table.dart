import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_selection_bloc/permissions_selection_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_table.dart';
import 'package:genesis/src/features/permissions/presentation/widgets/permission_status_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class PermissionsTable extends StatelessWidget {
  const PermissionsTable({required this.permissions, super.key});

  final List<Permission> permissions;

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
        BlocBuilder<PermissionsSelectionBloc, List<Permission>>(
          builder: (context, state) {
            return Checkbox(
              tristate: true,
              onChanged: (_) => context.read<PermissionsSelectionBloc>().add(
                PermissionsSelectionEvent.toggleAll(permissions),
              ),
              value: switch (state.length) {
                0 => false,
                final len when len == permissions.length => true,
                _ => null,
              },
            );
          },
        ),
        Text(context.$.role, style: TextStyle(color: Colors.white)),
        Text(context.$.status, style: TextStyle(color: Colors.white)),
        Text(context.$.uuid, style: TextStyle(color: Colors.white)),
        Text(context.$.createdAt, style: TextStyle(color: Colors.white)),
      ],
      length: permissions.length,
      cellsBuilder: (index) {
        final permission = permissions[index];
        return [
          BlocBuilder<PermissionsSelectionBloc, List<Permission>>(
            builder: (context, state) {
              return Checkbox(
                value: state.contains(permission),
                onChanged: (_) => context.read<PermissionsSelectionBloc>().add(
                  PermissionsSelectionEvent.toggle(permission),
                ),
              );
            },
          ),
          Text(permission.name, style: TextStyle(color: Colors.white)),
          PermissionStatusWidget(status: permission.status),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: SelectableText(
                    permission.uuid.value,
                    style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
                  ),
                ),
                WidgetSpan(child: const SizedBox(width: 8)),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: permission.uuid.value));
                      final snack = AppSnackBar.success('Скопировано в буфер обмена: ${permission.uuid.value}');
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('dd.MM.yyyy HH:mm').format(permission.createdAt),
            style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
          ),
          SizedBox.shrink(),
        ];
      },
    );
  }
}
