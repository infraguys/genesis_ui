import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/role_pages/role_list_page/widgets/roles_action_popup_menu_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_widgets/role_status_widget.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class RolesTable extends StatelessWidget {
  const RolesTable({required this.roles, super.key});

  final List<Role> roles;

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
        BlocBuilder<RolesSelectionBloc, List<Role>>(
          builder: (context, state) {
            return Checkbox(
              tristate: true,
              onChanged: (_) => context.read<RolesSelectionBloc>().add(
                RolesSelectionEvent.toggleAll(roles),
              ),
              value: switch (state.length) {
                0 => false,
                final len when len == roles.length => true,
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
      length: roles.length,
      cellsBuilder: (index) {
        final role = roles[index];
        return [
          BlocBuilder<RolesSelectionBloc, List<Role>>(
            builder: (context, state) {
              return Checkbox(
                value: state.contains(role),
                onChanged: (_) => context.read<RolesSelectionBloc>().add(
                  RolesSelectionEvent.toggle(role),
                ),
              );
            },
          ),
          Text(role.name, style: TextStyle(color: Colors.white)),
          RoleStatusWidget(status: role.status),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: SelectableText(
                    role.uuid.value,
                    style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
                  ),
                ),
                WidgetSpan(child: const SizedBox(width: 8)),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: role.uuid.value));
                      final snack = AppSnackBar.success('Скопировано в буфер обмена: ${role.uuid}');
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('dd.MM.yyyy HH:mm').format(role.createdAt),
            style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
          ),
          RolesActionPopupMenuButton(role: role),
        ];
      },
      onTap: (index) {
        final role = roles[index];
        context.goNamed(
          AppRoutes.role.name,
          pathParameters: {'uuid': role.uuid.value},
        );
      },
    );
  }
}
