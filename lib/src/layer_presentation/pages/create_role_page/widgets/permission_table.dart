part of '../create_role_page.dart';

class _PermissionsTable extends StatelessWidget {
  const _PermissionsTable({required this.permissions});

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
        final role = permissions[index];
        return [
          BlocBuilder<PermissionsSelectionBloc, List<Permission>>(
            builder: (context, state) {
              return Checkbox(
                value: state.contains(role),
                onChanged: (_) => context.read<PermissionsSelectionBloc>().add(
                  PermissionsSelectionEvent.toggle(role),
                ),
              );
            },
          ),
          Text(role.name, style: TextStyle(color: Colors.white)),
          StatusLabel(status: role.status),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: SelectableText(
                    role.uuid,
                    style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
                  ),
                ),
                WidgetSpan(child: const SizedBox(width: 8)),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: role.uuid));
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
          SizedBox.shrink(),
        ];
      },
    );
  }
}
