part of '../organization_details_page.dart';

class _SaveOrganizationButton extends StatelessWidget {
  const _SaveOrganizationButton({super.key, this.onPressed}); // ignore: unused_element_parameter

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.permissionNames.organizations.canWriteAll,
      child: SaveIconButton(onPressed: onPressed),
    );
  }
}
