part of '../organization_list_page.dart';

class _DeleteOrganizationButton extends StatelessWidget {
  const _DeleteOrganizationButton({super.key});

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
