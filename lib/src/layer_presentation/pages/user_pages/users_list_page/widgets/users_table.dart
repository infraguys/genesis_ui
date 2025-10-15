import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/user_pages/users_list_page/widgets/users_actions_popup_menu_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_widgets/user_status_widget.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/verified_label.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class UsersTable extends StatelessWidget {
  const UsersTable({
    required this.users,
    this.allowMultiSelect = true,
    super.key,
  });

  final List<User> users;
  final bool allowMultiSelect;

  @override
  Widget build(BuildContext context) {
    return AppTable(
      length: users.length,
      columnSpans: [
        TableSpan(extent: FixedSpanExtent(40.0)),
        TableSpan(extent: FractionalSpanExtent(2 / 10)),
        TableSpan(extent: FractionalSpanExtent(2 / 10)),
        TableSpan(extent: FractionalSpanExtent(4 / 10)),
        TableSpan(extent: FractionalSpanExtent(2 / 10)),
        TableSpan(extent: FixedSpanExtent(56.0)),
      ],
      headerCells: [
        BlocBuilder<UsersSelectionBloc, List<User>>(
          builder: (context, state) {
            return Checkbox(
              tristate: true,
              onChanged: (_) {
                if (allowMultiSelect) {
                  context.read<UsersSelectionBloc>().add(UsersSelectionEvent.toggleAll(users));
                }
              },
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
                onChanged: (_) {
                  if (!allowMultiSelect) {
                    context.read<UsersSelectionBloc>().add(UsersSelectionEvent.clear());
                  }
                  context.read<UsersSelectionBloc>().add(UsersSelectionEvent.toggle(user));
                },
              );
            },
          ),
          Text(user.username, style: TextStyle(color: Colors.white)),
          UserStatusWidget(status: user.status),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: SelectableText(
                    user.uuid.value,
                    style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
                  ),
                ),
                WidgetSpan(child: const SizedBox(width: 8)),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: user.uuid.value));
                      final snack = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Скопировано в буфер обмена: ${user.uuid.value}'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  ),
                ),
              ],
            ),
          ),
          VerifiedLabel(isVerified: users[index].emailVerified),
          UsersActionsPopupMenuButton(user: user),
        ];
      },
      onTap: (index) {
        final user = users[index];
        context.goNamed(
          AppRoutes.user.name,
          pathParameters: {'uuid': user.uuid.value},
          extra: user,
        );
      },
    );
  }
}
