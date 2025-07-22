import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/presentation/blocs/project_bloc/project_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateProjectDialog extends StatelessWidget {
  const UpdateProjectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final project = context.read<Project>();
    return AlertDialog(
      content: Text('Обновить проект?'),
      actions: [
        TextButton(onPressed: context.pop, child: Text(context.$.cancel)),
        TextButton(
          onPressed: () {
            context.pop();
            context.read<ProjectBloc>().add(ProjectEvent.delete(project.uuid));
          },
          child: Text(context.$.ok),
        ),
      ],
    );
  }
}
