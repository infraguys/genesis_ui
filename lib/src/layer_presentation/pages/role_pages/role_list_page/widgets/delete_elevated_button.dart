part of '../role_list_page.dart';

class _DeleteElevatedButton extends StatelessWidget {
  const _DeleteElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RolesSelectionBloc, List<Role>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }
        return DeleteElevatedButton(
          onPressed: () async {
            await showDialog<void>(
              context: context,
              builder: (context) => DeleteRolesDialog.multiple(
                roles: state,
                onDelete: () {
                  context.read<RolesBloc>().add(RolesEvent.deleteRoles(state));
                },
              ),
            );
          },
        );
      },
    );
  }
}
