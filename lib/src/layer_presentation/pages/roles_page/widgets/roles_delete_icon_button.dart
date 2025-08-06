import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/blocs/roles_selection_bloc/roles_selection_bloc.dart';
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
        return DeleteIconButton(onPressed: null);
      },
    );
  }
}
