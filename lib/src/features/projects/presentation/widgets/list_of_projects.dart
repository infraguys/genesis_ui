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
          children: [
            Text('Проекты', style: textTheme.headlineSmall),
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
                        child: Text(project.name, style: textTheme.bodyMedium),
                      ),
                    ),
                  );
                },
              ).toList(),
              // SizedBox(
              //   width: 300,
              //   height: 250,
              //   child: Card(
              //     child: Padding(
              //       padding: const EdgeInsets.all(12.0),
              //       child: Text('No projects yet'.hardcoded, style: textTheme.bodyMedium),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: 300,
              //   height: 250,
              //   child: Card(
              //     child: Padding(
              //       padding: const EdgeInsets.all(12.0),
              //       child: Text('No projects yet'.hardcoded, style: textTheme.bodyMedium),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: 300,
              //   height: 250,
              //   child: Card(
              //     child: Padding(
              //       padding: const EdgeInsets.all(12.0),
              //       child: Text('No projects yet'.hardcoded, style: textTheme.bodyMedium),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: 300,
              //   height: 250,
              //   child: Card(
              //     child: Padding(
              //       padding: const EdgeInsets.all(12.0),
              //       child: Text('No projects yet'.hardcoded, style: textTheme.bodyMedium),
              //     ),
              //   ),
              // ),
            ),
          ],
        );
      },
    );
  }
}
