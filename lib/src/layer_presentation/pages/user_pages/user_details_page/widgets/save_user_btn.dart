part of '../user_details_page.dart';

class _SaveUserButton extends StatelessWidget {
  const _SaveUserButton({super.key, this.onPressed}); //ignore: unused_element_parameter

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.permissionNames.users.canWriteAll,
      child: SaveIconButton(
        onPressed: onPressed,
      ),
    );
  }
}
