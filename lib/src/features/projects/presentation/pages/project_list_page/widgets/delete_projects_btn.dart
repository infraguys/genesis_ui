part of '../project_list_page.dart';

class _DeleteProjectsButton extends StatelessWidget {
  const _DeleteProjectsButton({super.key}); //ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsSelectionBloc, List<Project>>(
      builder: (_, state) {
        if (state.isEmpty) {
          return SizedBox.shrink();
        }

        final message = switch (state.length) {
          1 => context.$.deleteProjectConfirmation(state.single.name),
          final len => context.$.deleteProjectsConfirmation(len),
        };

        return DeleteElevatedButton(
          onPressed: () async {
            final projectsBloc = context.read<ProjectsBloc>();
            await showDialog<void>(
              context: context,
              builder: (context) => ConfirmationDialog(
                message: message,
                onDelete: () => projectsBloc.add(ProjectsEvent.deleteProjects(state)),
              ),
            );
          },
        );
      },
    );
  }
}
