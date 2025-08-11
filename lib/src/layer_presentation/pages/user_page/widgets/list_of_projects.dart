import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/project_bloc/project_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/project_card.dart';

class ListOfProjects extends StatelessWidget {
  const ListOfProjects({required this.userUuid, super.key});

  final String userUuid;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectDeletedState || state is ProjectUpdatedState) {
          context.read<UserProjectsBloc>().add(UserProjectsEvent.getProjects(userUuid));
        }
      },
      child: BlocBuilder<UserProjectsBloc, UserProjectsState>(
        builder: (context, state) {
          if (state is! UserProjectsLoadedState) {
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
                      width: 500,
                      height: 250,
                      child: ProjectCard(project: project),
                      // child: Card(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(12.0),
                      //     child: Column(
                      //       spacing: 4,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               project.name,
                      //               style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                      //             ),
                      //             Provider.value(
                      //               value: project,
                      //               child: ProjectActionPopupMenuButton(),
                      //             ),
                      //           ],
                      //         ),
                      //         Text(project.createdAt.toString(), style: textTheme.bodySmall),
                      //         Text(project.description, style: textTheme.bodySmall),
                      //         SizedBox(
                      //           height: 16,
                      //         ),
                      //         Text(
                      //           'Роли',
                      //           style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    );
                  },
                ).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
