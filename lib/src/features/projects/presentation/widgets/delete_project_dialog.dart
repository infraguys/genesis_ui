import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:go_router/go_router.dart';

class DeleteProjectDialog extends StatelessWidget {
  const DeleteProjectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final project = context.read<Project>();
    return AlertDialog(
      content: Text('Удалить проект?'),
      actions: [
        TextButton(onPressed: context.pop, child: Text('Отмена')),
        TextButton(
          onPressed: () {
            context.pop();
            // context.read<ProjectBloc>().add(ProjectEvent.delete(project.uuid));
          },
          child: Text('Ок'),
        ),
      ],
    );
  }
}
