import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_label.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/verified_label.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class UsersTable extends StatelessWidget {
  const UsersTable({required this.users, super.key});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return AppTable(
      length: users.length,
      columnSpans: [
        TableSpan(extent: FractionalTableSpanExtent(2 / 10)),
        TableSpan(extent: FractionalTableSpanExtent(2 / 10)),
        TableSpan(extent: FractionalTableSpanExtent(4 / 10)),
        TableSpan(extent: FractionalTableSpanExtent(2 / 10)),
      ],
      headerCells: [
        BlocBuilder<UsersSelectionBloc, List<User>>(
          builder: (context, state) {
            return Checkbox(
              tristate: true,
              onChanged: (_) => context.read<UsersSelectionBloc>().add(UsersSelectionEvent.toggleAll(users)),
              value: switch (state.length) {
                0 => false,
                final len when len == users.length => true,
                _ => null,
              },
            );
          },
        ),
        Text(context.$.user, style: TextStyle(color: Colors.white)),
        Text(context.$.status, style: TextStyle(color: Colors.white)),
        Text(context.$.uuid, style: TextStyle(color: Colors.white)),
        Text(context.$.verification, style: TextStyle(color: Colors.white)),
      ],
      cellsBuilder: (index) {
        final user = users[index];
        return [
          BlocBuilder<UsersSelectionBloc, List<User>>(
            builder: (context, state) {
              return Checkbox(
                value: state.contains(user),
                onChanged: (_) => context.read<UsersSelectionBloc>().add(UsersSelectionEvent.toggle(user)),
              );
            },
          ),
          Text(user.username, style: TextStyle(color: Colors.white)),
          StatusLabel(status: user.status),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: SelectableText(
                    user.uuid,
                    style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
                  ),
                ),
                WidgetSpan(child: const SizedBox(width: 8)),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: user.uuid));
                      final snack = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Скопировано в буфер обмена: ${user.uuid}'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  ),
                ),
              ],
            ),
          ),
          VerifiedLabel(isVerified: users[index].emailVerified),
        ];
      },
      onTap: (index) {
        final user = users[index];
        context.goNamed(
          AppRoutes.user.name,
          pathParameters: {'uuid': user.uuid},
          extra: user,
        );
      },
    );
    // return LayoutBuilder(
    //   builder: (context, constraints) {
    //     return TableView.builder(
    //       columnCount: 5,
    //       rowCount: users.length + 1,
    //       pinnedRowCount: 1,
    //       columnBuilder: (index) {
    //         const checkboxColumnPx = 40.0;
    //         final totalWidth = constraints.maxWidth;
    //         final rest = totalWidth - checkboxColumnPx;
    //         final remainingRatio = (rest / totalWidth).clamp(0.0, 1.0);
    //         return switch (index) {
    //           0 => TableSpan(extent: FixedSpanExtent(checkboxColumnPx)),
    //           1 => TableSpan(extent: FractionalTableSpanExtent(remainingRatio * (2 / 10))),
    //           2 => TableSpan(extent: FractionalTableSpanExtent(remainingRatio * (2 / 10))),
    //           3 => TableSpan(extent: FractionalTableSpanExtent(remainingRatio * (4 / 10))),
    //           4 => TableSpan(extent: FractionalTableSpanExtent(remainingRatio * (2 / 10))),
    //           _ => TableSpan(extent: FractionalTableSpanExtent(0 / 20)),
    //         };
    //       },
    //       rowBuilder: (index) => TableSpan(
    //         extent: const FixedTableSpanExtent(40),
    //         backgroundDecoration: SpanDecoration(
    //           border: SpanBorder(
    //             trailing: index > 0 ? BorderSide(color: Palette.color333333) : BorderSide.none,
    //           ),
    //         ),
    //       ),
    //       cellBuilder: (context, vicinity) {
    //         final isStickyHeader = vicinity.yIndex == 0;
    //         late final Widget child;
    //         if (vicinity.yIndex == 0) {
    //           child = switch (vicinity.xIndex) {
    //             0 => Checkbox(
    //               value: true,
    //               tristate: true,
    //               onChanged: (val) {},
    //             ),
    //             1 => Text(context.$.user, style: TextStyle(color: Colors.white)),
    //             2 => Text(context.$.status, style: TextStyle(color: Colors.white)),
    //             3 => Text(context.$.uuid, style: TextStyle(color: Colors.white)),
    //             4 => Text('is verified', style: TextStyle(color: Colors.white)),
    //             _ => Text(''),
    //           };
    //         } else {
    //           final user = users[vicinity.yIndex - 1];
    //           child = switch (vicinity.xIndex) {
    //             0 => Checkbox(
    //               value: true,
    //               tristate: true,
    //               onChanged: (val) {},
    //             ),
    //             1 => Text(user.username, style: TextStyle(color: Colors.white)),
    //             2 => StatusLabel(status: user.status),
    //             3 => RichText(
    //               text: TextSpan(
    //                 children: [
    //                   WidgetSpan(
    //                     alignment: PlaceholderAlignment.middle,
    //                     child: SelectableText(
    //                       user.uuid,
    //                       style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
    //                     ),
    //                   ),
    //                   WidgetSpan(child: const SizedBox(width: 8)),
    //                   WidgetSpan(
    //                     alignment: PlaceholderAlignment.middle,
    //                     child: IconButton(
    //                       icon: Icon(Icons.copy, color: Colors.white, size: 18),
    //                       onPressed: () {
    //                         Clipboard.setData(ClipboardData(text: 'dewdwew'));
    //                         final snack = SnackBar(
    //                           backgroundColor: Colors.green,
    //                           content: Text('Скопировано в буфер обмена: '),
    //                         );
    //                         ScaffoldMessenger.of(context).showSnackBar(snack);
    //                       },
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             4 => VerifiedLabel(isVerified: user.emailVerified),
    //             _ => Text('', style: TextStyle(color: Colors.white)),
    //           };
    //         }
    //         return TableViewCell(
    //           child: ColoredBox(
    //             color: isStickyHeader ? Colors.white.withValues(alpha: 0.05) : Colors.transparent,
    //             child: MouseRegion(
    //               cursor: isStickyHeader ? SystemMouseCursors.basic : SystemMouseCursors.click,
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                 child: Align(
    //                   alignment: Alignment.centerLeft,
    //                   child: child,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
    // return AppTable<User>(
    //   entities: users,
    //   title: Row(
    //     spacing: 48,
    //     children: [
    //       Expanded(flex: 2, child: Text(context.$.user)),
    //       Expanded(child: Text(context.$.status)),
    //       Expanded(flex: 4, child: Text(context.$.uuid)),
    //       Spacer(flex: 2),
    //     ],
    //   ),
    //   item: UsersListItem(),
    //   headerLeading: BlocBuilder<UsersSelectionBloc, List<User>>(
    //     builder: (_, state) {
    //       return Checkbox(
    //         value: switch (state.length) {
    //           0 => false,
    //           final len when len == users.length => true,
    //           _ => null,
    //         },
    //         tristate: true,
    //         onChanged: (val) {
    //           context.read<UsersSelectionBloc>().add(UsersSelectionEvent.toggleAll(users));
    //         },
    //       );
    //     },
    //   ),
    // );
  }
}
