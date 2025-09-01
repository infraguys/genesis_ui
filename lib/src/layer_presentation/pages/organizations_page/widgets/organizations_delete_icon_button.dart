import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_selection_bloc/organizations_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';

class OrganizationsDeleteIconButton extends StatelessWidget {
  const OrganizationsDeleteIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationsSelectionBloc, List<Organization>>(
      builder: (_, state) {
        if (state.isEmpty) {
          return SizedBox.shrink();
        }
        return DeleteElevatedButton(
          onPressed: () {
            context.read<OrganizationsBloc>().add(OrganizationsEvent.deleteOrganizations(state));
          },
        );
      },
    );
  }
}
