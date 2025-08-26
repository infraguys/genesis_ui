import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bindings_bloc/role_bindings_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/hexagon_icon_button.dart';
import 'package:genesis/src/theming/palette.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    required this.project,
    required this.roles,
    required this.userUuid,
    super.key,
  });

  final Project? project;
  final List<Role>? roles;
  final String userUuid;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Palette.color333333,
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // todo: вынести в типографику
                  Text(project!.name, style: TextStyle(color: Colors.white, fontSize: 20)),
                  Text(project!.description, style: TextStyle(color: Colors.white, fontSize: 14)),
                  SizedBox(height: 50),
                  Wrap(
                    spacing: 6.0,
                    children: roles!
                        .map(
                          (it) => Chip(
                            color: WidgetStatePropertyAll(Palette.color6DCF91.withValues(alpha: 10)),
                            surfaceTintColor: Colors.transparent,
                            label: Text(it.name.capitalize, style: TextStyle(fontSize: 14)),
                            deleteIcon: Icon(Icons.close),
                            onDeleted: () {
                              context.read<RoleBindingsBloc>().add(
                                RoleBindingsEvent.delete(
                                  userUuid: userUuid,
                                  roleUuid: it.uuid,
                                  projectUuid: project!.uuid,
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
            HexagonIconButton(
              iconData: Icons.add,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
