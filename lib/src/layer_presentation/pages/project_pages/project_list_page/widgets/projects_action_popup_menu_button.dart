import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';

class ProjectsActionPopupMenuButton extends StatelessWidget {
  const ProjectsActionPopupMenuButton({
    required this.project,
    super.key,
  });

  final Project project;

  @override
  Widget build(BuildContext context) {
    return TooltipVisibility(
      visible: false,
      child: PopupMenuButton<_PopupBtnValue>(
        clipBehavior: Clip.antiAlias,
        icon: Icon(Icons.more_vert),
        useRootNavigator: true,
        onSelected: (value) {
          final projects = List.generate(1, (_) => project);
          final child = switch (value) {
            _PopupBtnValue.deleteProject => ConfirmationDialog(
              message: context.$.deleteProjectConfirmation(project.name),
              onDelete: () => context.read<ProjectsBloc>().add(ProjectsEvent.deleteProjects(projects)),
            ),
          };
          showDialog<void>(
            context: context,
            builder: (_) => child,
          );
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: _PopupBtnValue.deleteProject,
              labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Palette.colorF04C4C)),
              child: Text(context.$.delete),
            ),
          ];
        },
      ),
    );
  }
}

enum _PopupBtnValue {
  deleteProject,
}
