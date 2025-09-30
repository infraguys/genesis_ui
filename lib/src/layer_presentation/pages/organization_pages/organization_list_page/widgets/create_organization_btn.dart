part of '../organization_list_page.dart';

class _CreateOrganizationButton extends StatelessWidget {
  const _CreateOrganizationButton({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return CreateIconButton(
      onPressed: () => context.goNamed(AppRoutes.createOrganization.name),
    );
  }
}
