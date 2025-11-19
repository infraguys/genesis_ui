part of '../role_details_page.dart';

class _DeleteRoleButton extends StatelessWidget {
  const _DeleteRoleButton({required this.role, super.key}); // ignore: unused_element_parameter

  final Role role;

  @override
  Widget build(BuildContext context) {
    return DeleteElevatedButton(
      onPressed: () async {
        final roleBLoc = context.read<RoleBloc>();
        await showDialog<void>(
          context: context,
          builder: (_) => ConfirmationDialog(
            message: context.$.deleteRole(role.name),
            onDelete: () => roleBLoc.add(RoleEvent.delete(role)),
          ),
        );
      },
    );
  }
}
