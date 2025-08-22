import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/projects/delete_project_params.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_selection_bloc/projects_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/widgets/delete_projects_dialog.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_icon_button.dart';

class DeleteProjectsIconButton extends StatelessWidget {
  const DeleteProjectsIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsSelectionBloc, List<Project>>(
      builder: (_, state) {
        if (state.isEmpty) {
          return SizedBox.shrink();
        }
        return DeleteIconButton(
          onPressed: () async {
            await showDialog<void>(
              context: context,
              builder: (context) => DeleteProjectsDialog(
                projects: state,
                onDelete: () {
                  final listOfParams = state.map((it) => DeleteProjectParams(uuid: it.uuid));
                  context.read<ProjectsBloc>().add(ProjectsEvent.deleteProjects(listOfParams.toList()));
                },
              ),
            );
          },
        );
      },
    );
  }
}
