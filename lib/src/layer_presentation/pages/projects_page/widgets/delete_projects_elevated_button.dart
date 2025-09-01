import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_selection_bloc/projects_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/widgets/delete_projects_dialog.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';

class DeleteProjectsElevatedButton extends StatelessWidget {
  const DeleteProjectsElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsSelectionBloc, List<Project>>(
      builder: (_, state) {
        if (state.isEmpty) {
          return SizedBox.shrink();
        }
        return DeleteElevatedButton(
          onPressed: () async {
            await showDialog<void>(
              context: context,
              builder: (context) {
                return DeleteProjectsDialog(
                  projects: state,
                  onDelete: () {
                    context.read<ProjectsBloc>().add(ProjectsEvent.deleteProjects(state));
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
