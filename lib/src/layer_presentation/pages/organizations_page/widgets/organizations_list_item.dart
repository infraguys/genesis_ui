import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_selection_bloc/organizations_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_label.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class OrganizationsListItem extends StatelessWidget {
  const OrganizationsListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final organization = context.read<Organization>();

    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: Theme.of(context).listTileTheme.copyWith(
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.zero,
          tileColor: Colors.transparent,
        ),
      ),
      child: ListTile(
        title: Row(
          spacing: 48,
          children: [
            Expanded(flex: 2, child: Text(organization.name)),
            Flexible(child: StatusLabel(status: organization.status)),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(organization.uuid),
                  IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: organization.uuid));
                      final snack = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Скопировано в буфер обмена: ${organization.uuid}'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  ),
                ],
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
        leading: BlocBuilder<OrganizationsSelectionBloc, List<Organization>>(
          builder: (context, state) {
            return Checkbox(
              value: state.contains(organization),
              onChanged: (_) {
                context.read<OrganizationsSelectionBloc>().add(
                  OrganizationsSelectionEvent.toggleOrganization(organization),
                );
              },
            );
          },
        ),
        onTap: () {
          context.goNamed(
            AppRoutes.organization.name,
            pathParameters: {'uuid': organization.uuid},
            extra: organization,
          );
        },
      ),
    );
  }
}
