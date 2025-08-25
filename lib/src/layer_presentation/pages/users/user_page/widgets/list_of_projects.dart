import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/params/projects/get_projects_params.dart';
import 'package:genesis/src/layer_presentation/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/project_card.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class ListOfProjects extends StatelessWidget {
  const ListOfProjects({required this.userUuid, super.key});

  final String userUuid;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return BlocBuilder<UserProjectsBloc, UserProjectsState>(
      builder: (context, state) {
        if (state is! UserProjectsLoadedState) {
          return AppProgressIndicator();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.$.projects, style: textTheme.headlineSmall),
            const SizedBox(height: 24),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                SizedBox(
                  width: 500,
                  height: 250,
                  child: ProjectCard.empty(
                    onTap: () {
                      final bloc = context.read<UserProjectsBloc>();
                      context.pushNamed<bool>(AppRoutes.createProject.name).then(
                        (value) {
                          if (value != null && value) {
                            bloc.add(
                              UserProjectsEvent.getProjects(GetProjectsParams(userUuid: userUuid)),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                for (final it in state.projectsWithRoles)
                  SizedBox(
                    width: 500,
                    height: 250,
                    child: ProjectCard(project: it.project, roles: it.roles),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
