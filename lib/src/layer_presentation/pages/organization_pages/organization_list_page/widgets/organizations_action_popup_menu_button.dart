import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';

class OrganizationsActionPopupMenuButton extends StatelessWidget {
  const OrganizationsActionPopupMenuButton({
    required this.organization,
    super.key,
  });

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return TooltipVisibility(
      visible: false,
      child: PopupMenuButton<_PopupBtnValue>(
        clipBehavior: Clip.antiAlias,
        icon: Icon(Icons.more_vert),
        onSelected: (value) {
          final organizations = List.generate(1, (_) => organization);
          final child = switch (value) {
            _PopupBtnValue.deleteOrganization => ConfirmationDialog(
              message: context.$.deleteOrgConfirmation(organizations.single.name),
              onDelete: () {
                context.read<OrganizationsBloc>().add(OrganizationsEvent.deleteOrganizations(organizations));
              },
            ),
          };
          showDialog<void>(
            context: context,
            builder: (_) {
              return child;
            },
          );
        },
        useRootNavigator: true,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: _PopupBtnValue.deleteOrganization,
              labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Palette.colorF04C4C)),
              child: Text(context.$.delete),
            ),
          ];
        },
      ),
    );
  }
}

enum _PopupBtnValue {
  // editRole,
  deleteOrganization,
}
