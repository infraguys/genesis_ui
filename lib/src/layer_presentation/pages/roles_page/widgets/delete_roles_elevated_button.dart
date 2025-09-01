import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_roles_dialog.dart';

class DeleteRolesElevatedButton extends StatelessWidget {
  const DeleteRolesElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RolesSelectionBloc, List<Role>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }
        return DeleteElevatedButton(
          onPressed: () async {
            await showDialog<void>(
              context: context,
              builder: (context) => DeleteRolesDialog.multiple(
                roles: state,
                onDelete: () {
                  context.read<RolesBloc>().add(RolesEvent.deleteRoles(state));
                },
              ),
            );
          },
        );
      },
    );
  }
}
