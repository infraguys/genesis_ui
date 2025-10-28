import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/databases_selection_cubit/databases_selection_cubit.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/cluster_selection_cubit/cluster_selection_cubit.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_table.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class DatabaseTable extends StatelessWidget {
  const DatabaseTable({
    required this.databases,
    this.allowMultiSelect = true,
    super.key,
  });

  final List<Database> databases;
  final bool allowMultiSelect;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DatabasesSelectionCubit, List<Database>>(
      // listenWhen: (_, current) => current is PgInstancesDeletedState,
      listener: (context, state) {
        context.read<ClusterSelectionCubit>().onClear();
      },
      child: AppTable(
        length: databases.length,
        columnSpans: [
          TableSpan(extent: FixedSpanExtent(40.0)),
          TableSpan(extent: FractionalSpanExtent(2 / 10)),
          TableSpan(extent: FractionalSpanExtent(2 / 10)),
          TableSpan(extent: FractionalSpanExtent(4 / 10)),
          TableSpan(extent: FractionalSpanExtent(2 / 10)),
          TableSpan(extent: FixedSpanExtent(56.0)),
        ],
        headerCells: [
          BlocBuilder<DatabasesSelectionCubit, List<Database>>(
            builder: (context, state) {
              return Checkbox(
                tristate: true,
                onChanged: (_) {
                  if (allowMultiSelect) {
                    context.read<DatabasesSelectionCubit>().onToggleAll(databases);
                  }
                },
                value: switch (state.length) {
                  0 => false,
                  final len when len == databases.length => true,
                  _ => null,
                },
              );
            },
          ),
          Text(context.$.user, style: TextStyle(color: Colors.white)),
          Text(context.$.status, style: TextStyle(color: Colors.white)),
          Text(context.$.uuid, style: TextStyle(color: Colors.white)),
          Text(context.$.createdAt, style: TextStyle(color: Colors.white)),
        ],
        cellsBuilder: (index) {
          final database = databases[index];
          return [
            BlocBuilder<DatabasesSelectionCubit, List<Database>>(
              builder: (context, state) {
                return Checkbox(
                  value: state.contains(database),
                  onChanged: (_) {
                    if (!allowMultiSelect) {
                      context.read<ClusterSelectionCubit>().onClear();
                    }
                    context.read<DatabasesSelectionCubit>().onToggle(database);
                  },
                );
              },
            ),
            Text(database.name, style: TextStyle(color: Colors.white)),
            SizedBox.shrink(),
            // PgInstanceStatusWidget(status: database.status),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SelectableText(
                      database.id.raw,
                      style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
                    ),
                  ),
                  WidgetSpan(child: const SizedBox(width: 8)),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: IconButton(
                      icon: Icon(Icons.copy, color: Colors.white, size: 18),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: database.id.raw));
                        final snack = SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(context.$.msgCopiedToClipboard(database.id.raw)),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snack);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Text(
              DateFormat('dd.MM.yyyy HH:mm').format(database.createdAt),
              style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
            ),
            SizedBox.shrink(),
          ];
        },
        onTap: (index) {
          final db = databases[index];
          context.goNamed(
            AppRoutes.pgDb.name,
            pathParameters: {
              'id': GoRouter.of(context).state.pathParameters['id']!,
              'db_id': db.id.raw,
            },
          );
        },
      ),
    );
  }
}
