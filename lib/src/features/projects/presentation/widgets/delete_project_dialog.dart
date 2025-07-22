import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/presentation/blocs/project_bloc/project_bloc.dart';
import 'package:go_router/go_router.dart';

class DeleteProjectDialog extends StatelessWidget {
  const DeleteProjectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final project = context.read<Project>();
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectDeletedState) {
          context.pop();
        }
      },
      child: AlertDialog(
        content: Text(context.$.deleteProject),
        actions: [
          TextButton(onPressed: context.pop, child: Text(context.$.cancel)),
          TextButton(
            onPressed: () {
              context.read<ProjectBloc>().add(
                ProjectEvent.delete(project.uuid),
              );
            },
            child: Text(context.$.ok),
          ),
        ],
      ),
    );
  }
}
