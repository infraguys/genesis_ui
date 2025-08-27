import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bindings_bloc/role_bindings_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/add_project_card.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/project_card.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class ListOfProjects extends StatelessWidget {
  const ListOfProjects({required this.userUuid, super.key});

  final String userUuid;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoleBindingsBloc, RoleBindingsState>(
      listenWhen: (_, current) => current is RoleBindingsDeletedState,
      listener: (context, state) {
        context.read<UserProjectsBloc>().add(
          UserProjectsEvent.getProjects(userUuid),
        );
      },
      child: BlocBuilder<UserProjectsBloc, UserProjectsState>(
        builder: (context, state) {
          if (state is! UserProjectsLoadedState) {
            return AppProgressIndicator();
          }
          return Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              SizedBox(
                width: 500,
                height: 250,
                child: AddProjectCard(
                  onTap: () async {
                    final bloc = context.read<UserProjectsBloc>();
                    final isCreated = await context.pushNamed<bool>(
                      AppRoutes.attachProject.name,
                      pathParameters: GoRouterState.of(context).pathParameters,
                    );
                    if (isCreated == true) {
                      bloc.add(UserProjectsEvent.getProjects(userUuid));
                    }
                  },
                ),
              ),
              for (final it in state.projectsWithRoles)
                SizedBox(
                  width: 500,
                  height: 250,
                  child: ProjectCard(project: it.project, roles: it.roles, userUuid: userUuid),
                ),
            ],
          );
        },
      ),
    );
  }
}
