import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:provider/provider.dart';

class RolesActionPopupMenuButton extends StatelessWidget {
  const RolesActionPopupMenuButton({
    required this.role,
    super.key,
  });

  final Role role;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_PopupBtnValue>(
      icon: Icon(Icons.more_vert),
      onSelected: (value) {
        final child = switch (value) {
          _PopupBtnValue.addRole => Placeholder(),
          _PopupBtnValue.editRole => Placeholder(),
          _PopupBtnValue.deleteRole => Placeholder(),
        };
        showDialog<void>(
          context: context,
          builder: (_) {
            return Provider.value(
              value: context.read<Project>(),
              child: child,
            );
          },
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      useRootNavigator: true,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: _PopupBtnValue.addRole,
            child: Text(context.$.add),
          ),
          PopupMenuItem(
            value: _PopupBtnValue.editRole,
            child: Text(context.$.edit),
          ),
          PopupMenuItem(
            value: _PopupBtnValue.deleteRole,
            labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Colors.red)),
            child: Text(context.$.delete),
          ),
        ];
      },
    );
  }
}

enum _PopupBtnValue {
  addRole,
  editRole,
  deleteRole,
}
