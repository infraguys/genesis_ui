import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';

class ListOfProjects extends StatelessWidget {
  const ListOfProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        if (state is! ProjectsLoadedState) {
          return Center(child: CupertinoActivityIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Проекты', style: textTheme.headlineSmall),
            const SizedBox(height: 24),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: state.projects.map(
                (project) {
                  return SizedBox(
                    width: 300,
                    height: 250,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.name,
                              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(project.createdAt.toString(), style: textTheme.bodySmall),
                            Text(project.description, style: textTheme.bodySmall),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Роли',
                              style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        );
      },
    );
  }
}
