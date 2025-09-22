part of '../project_list_page.dart';

class _CreateProjectButton extends StatelessWidget {
  const _CreateProjectButton({super.key}); //ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return CreateIconButton(
      onPressed: () => context.pushNamed(AppRoutes.createProject.name),
    );
  }
}
