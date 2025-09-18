part of '../role_list_page.dart';

class _CreateIconButton extends StatelessWidget {
  const _CreateIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateIconButton(
      onPressed: () {
        context.goNamed(AppRoutes.createRole.name);
      },
    );
  }
}
