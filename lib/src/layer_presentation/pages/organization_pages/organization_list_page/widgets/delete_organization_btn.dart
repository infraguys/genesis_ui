part of '../organization_list_page.dart';

class _DeleteOrganizationButton extends StatelessWidget {
  const _DeleteOrganizationButton({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationsSelectionBloc, List<Organization>>(
      builder: (_, state) {
        final message = switch (state.length) {
          1 => context.$.deleteOrganizationConfirmation(state.single.name),
          final len => context.$.deleteOrganizationsConfirmation(len),
        };

        return Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: state.isNotEmpty,
          child: DeleteElevatedButton(
            onPressed: () async {
              final organizationsBloc = context.read<OrganizationsBloc>();
              await showDialog<void>(
                context: context,
                builder: (_) => ConfirmationDialog(
                  message: message,
                  onDelete: () => organizationsBloc.add(OrganizationsEvent.deleteOrganizations(state)),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
