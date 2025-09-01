import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';

class DeleteOrganizationsDialog extends StatelessWidget {
  const DeleteOrganizationsDialog({
    required this.organizations,
    super.key,
    this.onDelete,
  });

  final List<Organization> organizations;
  final VoidCallback? onDelete;

  String getContent(BuildContext context) {
    if (organizations.length == 1) {
      return 'Удалить организацию ${organizations.single.name}?';
    }
    return 'Удалить выбранные(${organizations.length}) организации?';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(getContent(context)),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text(context.$.cancel),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Palette.colorF04C4C),
          onPressed: () {
            context.pop();
            onDelete?.call(organizations);
          },
          child: Text(context.$.ok),
        ),
      ],
    );
    ;
  }
}
