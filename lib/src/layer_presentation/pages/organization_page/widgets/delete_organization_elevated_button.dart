import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';

class DeleteOrganizationElevatedButton extends StatelessWidget {
  const DeleteOrganizationElevatedButton({required this.organization, super.key});

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return DeleteElevatedButton(
      onPressed: () {
        context.read<OrganizationBloc>().add(OrganizationEvent.delete(organization));
      },
    );
  }
}
