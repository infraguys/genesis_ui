part of '../organization_details_page.dart';

class _DeleteOrganizationButton extends StatelessWidget {
  const _DeleteOrganizationButton({required this.organization, super.key});

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return DeleteElevatedButton(
      onPressed: () async {
        final organizationBloc = context.read<OrganizationBloc>();
        await showDialog<void>(
          context: context,
          builder: (_) => ConfirmationDialog(
            message: context.$.deleteOrganizationConfirmation(organization.name),
            onDelete: () => organizationBloc.add(OrganizationEvent.delete(organization)),
          ),
        );
      },
    );
  }
}
