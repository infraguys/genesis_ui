part of '../user_details_page.dart';

class _DeleteUserButton extends StatelessWidget {
  const _DeleteUserButton({required this.user, super.key}); // ignore: unused_element_parameter

  final User user;

  bool _canDeleteOwn(BuildContext context) {
    return (context.permissionNames.users.canDeleteOwn && context.isMe(user.uuid)) || context.permissionNames.isAdmin;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.permissionNames.users.canDeleteAll || _canDeleteOwn(context),
      child: DeleteElevatedButton(
        onPressed: () async {
          final userBloc = context.read<UserBloc>();
          await showDialog<void>(
            context: context,
            builder: (_) => ConfirmationDialog(
              message: context.$.deleteUser(user.username),
              onDelete: () => userBloc.add(UserEvent.deleteUser(user)),
            ),
          );
        },
      ),
    );
  }
}
