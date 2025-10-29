import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bindings_bloc/role_bindings_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/add_project_card.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/project_card.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class ListOfProjects extends StatelessWidget {
  const ListOfProjects({required this.userUuid, super.key});

  final UserUUID userUuid;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<RoleBindingsBloc, RoleBindingsState>(
          listenWhen: (_, current) => current is RoleBindingsDeletedState,
          listener: (context, _) {
            context.read<UserProjectsBloc>().add(UserProjectsEvent.getProjects(userUuid));
          },
        ),
        // BlocListener<UserProjectsBloc, UserProjectsState>(
        //   listener: (context, state) {
        //     final messenger = ScaffoldMessenger.of(context);
        //
        //     switch (state) {
        //       case UserProjectsPermissionFailureState(:final message):
        //         messenger.showSnackBar(AppSnackBar.failure(message));
        //       default:
        //     }
        //   },
        // ),
      ],
      child: BlocBuilder<UserProjectsBloc, UserProjectsState>(
        builder: (context, state) {
          return switch (state) {
            UserProjectsPermissionFailureState() => SizedBox.shrink(),
            _ when state is! UserProjectsLoadedState => AppProgressIndicator(),
            _ => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24.0,
              children: [
                Text(context.$.projects, style: textTheme.headlineLarge),
                Wrap(
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
                        child: ProjectCard(project: it.project, roles: it.roles, userUUID: userUuid),
                      ),
                  ],
                ),
              ],
            ),
          };
        },
      ),
    );
  }
}
