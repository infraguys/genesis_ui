part of '../user_page.dart';

class _ConfirmEmailButton extends StatelessWidget {
  const _ConfirmEmailButton({required this.user, super.key}); // ignore: unused_element_parameter

  final User user;

  @override
  Widget build(BuildContext context) {
    if (user.emailVerified) {
      return const SizedBox.shrink();
    }
    return ConfirmEmailElevatedButton(
      onPressed: () {
        context.read<UserBloc>().add(UserEvent.forceConfirmEmail(user));
      },
    );
  }
}
