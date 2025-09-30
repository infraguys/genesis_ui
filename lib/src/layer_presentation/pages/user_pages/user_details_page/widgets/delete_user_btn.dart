part of '../user_details_page.dart';

class _DeleteUserButton extends StatelessWidget {
  const _DeleteUserButton({required this.user, super.key}); // ignore: unused_element_parameter

  final User user;

  @override
  Widget build(BuildContext context) {
    final permUserNames = context.permissionNames.users;
    return Visibility(
      visible: permUserNames.canDeleteAll || (permUserNames.canDeleteOwn && context.isMe(user.uuid)),
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
