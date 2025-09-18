part of '../organization_list_page.dart';

class _CreateOrganizationButton extends StatelessWidget {
  const _CreateOrganizationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateIconButton(
      onPressed: () {
        context.goNamed(AppRoutes.createOrganization.name);
      },
    );
  }
}
