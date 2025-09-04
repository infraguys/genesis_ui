import 'package:flutter/material.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/create_icon_button.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class OrganizationsCreateIconButton extends StatelessWidget {
  const OrganizationsCreateIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateIconButton(
      onPressed: () {
        context.goNamed(AppRoutes.createOrganization.name);
      },
    );
  }
}
