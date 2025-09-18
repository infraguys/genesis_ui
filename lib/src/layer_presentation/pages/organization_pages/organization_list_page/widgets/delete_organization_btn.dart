part of '../organization_list_page.dart';

class _DeleteOrganizationButton extends StatelessWidget {
  const _DeleteOrganizationButton({super.key});

  String createMessage(BuildContext context, List<Organization> organizations) {
    if (organizations.length == 1) {
      return context.$.deleteOrganizationConfirmation(organizations.single.name);
    }
    return context.$.deleteOrganizationsConfirmation(organizations.length);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationsSelectionBloc, List<Organization>>(
      builder: (_, state) {
        if (state.isEmpty) {
          return SizedBox.shrink();
        }
        return DeleteElevatedButton(
          onPressed: () async {
            final organizationsBloc = context.read<OrganizationsBloc>();
            await showDialog<void>(
              context: context,
              builder: (context) {
                return ConfirmationDialog(
                  message: createMessage(context, state),
                  onDelete: () {
                    organizationsBloc.add(OrganizationsEvent.deleteOrganizations(state));
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
