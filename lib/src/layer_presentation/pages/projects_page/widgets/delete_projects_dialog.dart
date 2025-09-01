import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';

class DeleteProjectsDialog extends StatelessWidget {
  const DeleteProjectsDialog({required this.projects, super.key, this.onDelete});

  final List<Project> projects;
  final VoidCallback? onDelete;

  String getContent(List<Project> projects) {
    if (projects.length == 1) {
      return 'Удалить проект ${projects.single.name}?';
    }
    return 'Удалить выбранные(${projects.length}) проекты?';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(getContent(projects)),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text(context.$.cancel),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Palette.colorF04C4C),
          onPressed: () {
            context.pop();
            onDelete?.call();
          },
          child: Text(context.$.ok),
        ),
      ],
    );
  }
}
