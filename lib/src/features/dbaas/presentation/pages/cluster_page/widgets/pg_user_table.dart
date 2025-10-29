import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_users_bloc/pg_users_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_users_selection_cubit/pg_users_selection_cubit.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/cluster_page/widgets/pg_user_status_widget.dart';
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
    return BlocListener<PgUsersBloc, PgUsersState>(
      listenWhen: (_, current) => current is PgUsersDeletedState,
      listener: (context, state) => context.read<PgUsersSelectionCubit>().onClear(),
      child: AppTable(
        columnSpans: [
          TableSpan(extent: FixedSpanExtent(40.0)),
          TableSpan(extent: FractionalTableSpanExtent(2 / 10)),
          TableSpan(extent: FractionalTableSpanExtent(2 / 10)),
          TableSpan(extent: FractionalTableSpanExtent(4 / 10)),
          TableSpan(extent: FractionalTableSpanExtent(2 / 10)),
          TableSpan(extent: FixedSpanExtent(56.0)),
        ],
        headerCells: [
          BlocBuilder<PgUsersSelectionCubit, List<PgUser>>(
            builder: (context, state) {
              return Checkbox(
                tristate: true,
                onChanged: (_) {
                  if (allowMultiSelect) {
                    context.read<PgUsersSelectionCubit>().onToggleAll(pgUsers);
                  }
                },
                value: switch (state.length) {
                  0 => false,
                  final len when len == pgUsers.length => true,
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
        length: pgUsers.length,
        cellsBuilder: (index) {
          final pgUser = pgUsers[index];
          return [
            BlocBuilder<PgUsersSelectionCubit, List<PgUser>>(
              builder: (context, state) {
                return Checkbox(
                  value: state.contains(pgUser),
                  onChanged: (_) {
                    if (!allowMultiSelect) {
                      context.read<PgUsersSelectionCubit>().onClear();
                    }
                    context.read<PgUsersSelectionCubit>().onToggle(pgUser);
                  },
                );
              },
            ),
            Text(pgUser.name, style: TextStyle(color: Colors.white)),
            PgUserStatusWidget(status: pgUser.status),
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
                        final snack = AppSnackBar.success(context.$.msgCopiedToClipboard(pgUser.id.raw));
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
          context.goNamed(
            AppRoutes.pgUser.name,
            pathParameters: {
              'cluster_id': GoRouter.of(context).state.pathParameters['cluster_id']!,
              'user_id': pgUsers[index].id.raw,
            },
          );
        },
      ),
    );
  }
}
