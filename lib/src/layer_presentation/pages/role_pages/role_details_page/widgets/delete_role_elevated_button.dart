part of '../role_details_page.dart';

class _DeleteElevatedButton extends StatelessWidget {
  const _DeleteElevatedButton({required this.role, super.key});

  final Role role;

  @override
  Widget build(BuildContext context) {
    return DeleteElevatedButton(
      onPressed: () async {
        await showDialog<void>(
          context: context,
          builder: (_) {
            return DeleteRolesDialog.single(
              role: role,
              onDelete: () => context.read<RoleBloc>().add(RoleEvent.delete(role)),
            );
          },
        );
      },
    );
  }
}
