part of '../create_organization_page.dart';

class _CreateOrganizationButton extends StatelessWidget {
  const _CreateOrganizationButton({
    super.key, // ignore: unused_element_parameter
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SaveIconButton(onPressed: onPressed);
  }
}
