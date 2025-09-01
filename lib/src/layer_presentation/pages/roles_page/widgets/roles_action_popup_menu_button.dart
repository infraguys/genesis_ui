import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/widgets/delete_roles_dialog.dart';
import 'package:genesis/src/theming/palette.dart';

class RolesActionPopupMenuButton extends StatelessWidget {
  const RolesActionPopupMenuButton({
    required this.role,
    super.key,
  });

  final Role role;

  @override
  Widget build(BuildContext context) {
    return TooltipVisibility(
      visible: false,
      child: PopupMenuButton<_PopupBtnValue>(
        clipBehavior: Clip.antiAlias,
        icon: Icon(Icons.more_vert),
        onSelected: (value) {
          final roles = List.generate(1, (_) => role);
          final child = switch (value) {
            _PopupBtnValue.deleteRole => DeleteRolesDialog(
              roles: roles,
              onDelete: () => context.read<RolesBloc>().add(RolesEvent.deleteRoles(roles)),
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
              value: _PopupBtnValue.deleteRole,
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
  deleteRole,
}
