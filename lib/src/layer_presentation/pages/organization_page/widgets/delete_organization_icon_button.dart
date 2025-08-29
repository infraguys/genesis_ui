import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_icon_button.dart';

class DeleteOrganizationIconButton extends StatelessWidget {
  const DeleteOrganizationIconButton({required this.uuid, super.key});

  final OrganizationUUID uuid;

  @override
  Widget build(BuildContext context) {
    return DeleteIconButton(
      onPressed: () {
        context.read<OrganizationBloc>().add(OrganizationEvent.delete(uuid));
      },
    );
  }
}
