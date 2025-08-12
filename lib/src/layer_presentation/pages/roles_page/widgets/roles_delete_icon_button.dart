import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/roles/delete_role_params.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_icon_button.dart';

class RolesDeleteIconButton extends StatelessWidget {
  const RolesDeleteIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RolesSelectionBloc, List<Role>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }
        return DeleteIconButton(
          onPressed: () {
            final listOfParams = state.map((it) => DeleteRoleParams(uuid: it.uuid));
            context.read<RolesBloc>().add(RolesEvent.deleteRoles(listOfParams.toList()));
          },
        );
      },
    );
  }
}
