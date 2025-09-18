part of '../user_details_page.dart';

class _DeleteUserElevatedButton extends StatelessWidget {
  const _DeleteUserElevatedButton({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return DeleteElevatedButton(
      onPressed: () async {
        final userBloc = context.read<UserBloc>();
        await showDialog<void>(
          context: context,
          builder: (context) {
            return ConfirmationDialog(
              message: context.$.deleteUser(user.username),
              onDelete: () => userBloc.add(UserEvent.deleteUser(user)),
            );
          },
        );
      },
    );
  }
}
