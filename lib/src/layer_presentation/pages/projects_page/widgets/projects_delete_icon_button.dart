import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/blocs/projects_selection_bloc/projects_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_icon_button.dart';

class ProjectsDeleteIconButton extends StatelessWidget {
  const ProjectsDeleteIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsSelectionBloc, List<Project>>(
      builder: (_, state) {
        if (state.isEmpty) {
          return SizedBox.shrink();
        }
        return DeleteIconButton(
          onPressed: null,
        );
      },
    );
  }
}
