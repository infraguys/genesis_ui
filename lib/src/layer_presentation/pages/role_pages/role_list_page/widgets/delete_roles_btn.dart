part of '../role_list_page.dart';

class _DeleteRolesButton extends StatelessWidget {
  const _DeleteRolesButton({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RolesSelectionBloc, List<Role>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }

        final message = switch (state.length) {
          1 => context.$.deleteRole(state.single.name),
          final len => context.$.deleteRoles(len),
        };

        return DeleteElevatedButton(
          onPressed: () async {
            final rolesBloc = context.read<RolesBloc>();
            await showDialog<void>(
              context: context,
              builder: (context) => ConfirmationDialog(
                message: message,
                onDelete: () => rolesBloc.add(RolesEvent.deleteRoles(state)),
              ),
            );
          },
        );
      },
    );
  }
}
