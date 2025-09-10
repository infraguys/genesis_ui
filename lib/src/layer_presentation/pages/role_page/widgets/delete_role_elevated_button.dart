import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bloc/role_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_roles_dialog.dart';

class DeleteRoleElevatedButton extends StatelessWidget {
  const DeleteRoleElevatedButton({required this.role, super.key});

  final Role role;

  @override
  Widget build(BuildContext context) {
    return DeleteElevatedButton(
      onPressed: () async {
        await showDialog<void>(
          context: context,
          builder: (_) {
            return DeleteRolesDialog.single(
              role: role,
              onDelete: () => context.read<RoleBloc>().add(RoleEvent.delete(role)),
            );
          },
        );
      },
    );
  }
}
