part of '../user_details_page.dart';

class _ConfirmEmailButton extends StatelessWidget {
  const _ConfirmEmailButton({required this.user, super.key}); // ignore: unused_element_parameter

  final User user;

  @override
  Widget build(BuildContext context) {
    return ConfirmEmailElevatedButton(
      onPressed: () {
        context.read<UserBloc>().add(UserEvent.forceConfirmEmail(user));
      },
    );
  }
}
