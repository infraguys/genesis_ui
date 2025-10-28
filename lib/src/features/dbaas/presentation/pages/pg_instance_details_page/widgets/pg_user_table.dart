import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_table.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class PgUsersTable extends StatelessWidget {
  const PgUsersTable({
    required this.pgUsers,
    super.key,
    this.allowMultiSelect = true,
  });

  final List<PgUser> pgUsers;
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
            // if (allowMultiSelect) {
            //   context.read<NodesSelectionCubit>().onToggleAll(pgUsers);
            // }
          },
          value: false,
          // value: switch (state.length) {
          //   0 => false,
          //   final len when len == pgUsers.length => true,
          //   _ => null,
          // },
        ),
        Text('Nodes'.hardcoded, style: TextStyle(color: Colors.white)),
        Text(context.$.status, style: TextStyle(color: Colors.white)),
        Text(context.$.uuid, style: TextStyle(color: Colors.white)),
        Text(context.$.createdAt, style: TextStyle(color: Colors.white)),
      ],
      length: pgUsers.length,
      cellsBuilder: (index) {
        final pgUser = pgUsers[index];
        return [
          Checkbox(
            value: false,
            onChanged: (_) {
              // if (!allowMultiSelect) {
              //   context.read<NodesSelectionCubit>().onClear();
              // }
              // context.read<NodesSelectionCubit>().onToggle(pgUser);
            },
          ),
          Text(pgUser.name, style: TextStyle(color: Colors.white)),
          SizedBox.shrink(),
          // NodeStatusWidget(status: pgUser.status),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: SelectableText(
                    pgUser.id.raw,
                    style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
                  ),
                ),
                WidgetSpan(child: const SizedBox(width: 8)),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: pgUser.id.raw));
                      final snack = AppSnackBar.success('Скопировано в буфер обмена: ${pgUser.id}');
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('dd.MM.yyyy HH:mm').format(pgUser.createdAt),
            style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
          ),
          SizedBox.shrink(),
          // ProjectsActionPopupMenuButton(project: project),
        ];
      },
      onTap: (index) {
        final pgUser = pgUsers[index];
        context.goNamed(
          AppRoutes.pgUser.name,
          pathParameters: {
            'id': GoRouter.of(context).state.pathParameters['id']!,
            'pg_user_id': pgUser.id.raw,
          },
        );
      },
    );
  }
}
