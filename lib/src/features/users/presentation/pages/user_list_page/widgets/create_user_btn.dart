part of '../user_list_page.dart';

class _CreateUserButton extends StatelessWidget {
  const _CreateUserButton({
    super.key, // ignore: unused_element_parameter
  });

  @override
  Widget build(BuildContext context) {
    return CreateIconButton(
      onPressed: () async {
        await showDialog<void>(
          context: context,
          builder: (context) => Dialog(child: CreateUserDialog()),
        );
      },
    );
  }
}
