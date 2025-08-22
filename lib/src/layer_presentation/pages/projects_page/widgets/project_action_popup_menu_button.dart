import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/widgets/update_project_dialog.dart';
import 'package:provider/provider.dart';

class ProjectActionPopupMenuButton extends StatelessWidget {
  const ProjectActionPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_PopupBtnValue>(
      icon: Icon(Icons.more_vert),
      onSelected: (value) {
        final child = switch (value) {
          _PopupBtnValue.updateProject => UpdateProjectDialog(),
        };
        showDialog<void>(
          context: context,
          builder: (_) {
            return Provider.value(
              value: context.read<Project>(),
              child: child,
            );
          },
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      useRootNavigator: true,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: _PopupBtnValue.updateProject,
            child: Text('Update'.hardcoded),
          ),
        ];
      },
    );
  }
}

enum _PopupBtnValue {
  updateProject,
}
