import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/presentation/widgets/delete_project_dialog.dart';
import 'package:provider/provider.dart';

class ProjectActionPopupMenuButton extends StatelessWidget {
  const ProjectActionPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_PopupBtnValue>(
      onSelected: (value) {
        final child = switch (value) {
          _PopupBtnValue.deleteProject => DeleteProjectDialog(),
          _ => SizedBox.shrink(),
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
            value: _PopupBtnValue.deleteProject,
            labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Colors.red)),
            child: Text(context.$.delete),
          ),
        ];
      },
    );
  }
}

enum _PopupBtnValue {
  deleteProject,
}
