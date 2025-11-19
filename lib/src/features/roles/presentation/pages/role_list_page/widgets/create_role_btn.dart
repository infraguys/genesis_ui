part of '../role_list_page.dart';

class _CreateRoleButton extends StatelessWidget {
  const _CreateRoleButton({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return CreateIconButton(
      onPressed: () => context.goNamed(AppRoutes.createRole.name),
    );
  }
}
