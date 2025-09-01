import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bindings_bloc/role_bindings_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    required this.project,
    required this.roles,
    required this.userUUID,
    super.key,
  });

  final Project project;
  final List<Role>? roles;
  final UserUUID userUUID;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Palette.color333333,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // todo: вынести в типографику
                  Text(project.name, style: TextStyle(color: Colors.white, fontSize: 20)),
                  Text(project.description, style: TextStyle(color: Colors.white, fontSize: 14)),
                  SizedBox(height: 50),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: roles!
                        .map(
                          (it) => InputChip(
                            label: Text(it.name),
                            onDeleted: () {
                              context.read<RoleBindingsBloc>().add(
                                RoleBindingsEvent.delete(
                                  userUUID: userUUID,
                                  roleUUID: it.uuid,
                                  projectUUID: project.uuid,
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            SizedBox.square(
              dimension: 44,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Palette.colorFF8900),
                ),
                child: Icon(Icons.add, color: Palette.color1B1B1D),
                onPressed: () async {
                  final bloc = context.read<UserProjectsBloc>();
                  final isCreated = await context.pushNamed<bool>(
                    AppRoutes.attachRoles.name,
                    pathParameters: {
                      'projectUuid': project.uuid.value,
                      ...GoRouterState.of(context).pathParameters,
                    },
                    extra: GoRouterState.of(context).extra,
                  );

                  if (isCreated == true) {
                    bloc.add(UserProjectsEvent.getProjects(userUUID));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
