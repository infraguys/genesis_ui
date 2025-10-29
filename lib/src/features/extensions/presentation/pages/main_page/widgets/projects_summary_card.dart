import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_bloc/projects_bloc.dart';

class ProjectsSummaryCard extends StatelessWidget {
  const ProjectsSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Projects', style: textTheme.titleMedium),
                BlocBuilder<ProjectsBloc, ProjectsState>(
                  builder: (context, state) {
                    if (state is! ProjectsLoadedState) {
                      return Text(
                        'Loading...',
                        style: textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                      );
                    }
                    final projects = state.projects;
                    return Text(
                      projects.length.toString(),
                      style: textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
