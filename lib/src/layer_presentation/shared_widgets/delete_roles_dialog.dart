import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';

class DeleteRolesDialog extends StatelessWidget {
  const DeleteRolesDialog._({required this.roles, super.key, this.onDelete});

  DeleteRolesDialog.single({required Role role, Key? key, VoidCallback? onDelete})
    : this._(
        key: key,
        roles: List.generate(1, (_) => role),
        onDelete: onDelete,
      );

  const DeleteRolesDialog.multiple({required List<Role> roles, Key? key, VoidCallback? onDelete})
    : this._(
        key: key,
        roles: roles,
        onDelete: onDelete,
      );

  final List<Role> roles;
  final VoidCallback? onDelete;

  String getContent(BuildContext context) {
    if (roles.length == 1) {
      return context.$.deleteRole(roles.single.name);
    }
    return context.$.deleteRoles(roles.length);
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
            onDelete?.call();
          },
          child: Text(context.$.ok),
        ),
      ],
    );
  }
}
