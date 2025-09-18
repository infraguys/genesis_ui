part of '../organization_details_page.dart';

class _DeleteOrganizationButton extends StatelessWidget {
  const _DeleteOrganizationButton({required this.organization, super.key});

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
