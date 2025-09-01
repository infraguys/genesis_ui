import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_selection_bloc/organizations_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/widgets/organizations_action_popup_menu_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_label.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class OrganizationsTable extends StatelessWidget {
  const OrganizationsTable({required this.organizations, super.key});

  final List<Organization> organizations;

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
        BlocBuilder<OrganizationsSelectionBloc, List<Organization>>(
          builder: (context, state) {
            return Checkbox(
              tristate: true,
              onChanged: (_) => context.read<OrganizationsSelectionBloc>().add(
                OrganizationsSelectionEvent.toggleAll(organizations),
              ),
              value: switch (state.length) {
                0 => false,
                final len when len == organizations.length => true,
                _ => null,
              },
            );
          },
        ),
        Text(context.$.organization, style: TextStyle(color: Colors.white)),
        Text(context.$.status, style: TextStyle(color: Colors.white)),
        Text(context.$.uuid, style: TextStyle(color: Colors.white)),
        Text(context.$.createdAt, style: TextStyle(color: Colors.white)),
      ],
      length: organizations.length,
      cellsBuilder: (index) {
        final organization = organizations[index];
        return [
          BlocBuilder<OrganizationsSelectionBloc, List<Organization>>(
            builder: (context, state) {
              return Checkbox(
                value: state.contains(organization),
                onChanged: (_) => context.read<OrganizationsSelectionBloc>().add(
                  OrganizationsSelectionEvent.toggle(organization),
                ),
              );
            },
          ),
          Text(organization.name, style: TextStyle(color: Colors.white)),
          StatusLabel(status: organization.status),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: SelectableText(
                    organization.uuid.value,
                    style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
                  ),
                ),
                WidgetSpan(child: const SizedBox(width: 8)),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: organization.uuid.value));
                      final snack = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Скопировано в буфер обмена: ${organization.uuid}'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('dd.MM.yyyy HH:mm').format(organization.createdAt),
            style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
          ),
          OrganizationsActionPopupMenuButton(organization: organization),
        ];
      },
      onTap: (index) {
        final organization = organizations[index];
        context.goNamed(
          AppRoutes.organization.name,
          pathParameters: {'uuid': organization.uuid.value},
          extra: organization,
        );
      },
    );
  }
}
