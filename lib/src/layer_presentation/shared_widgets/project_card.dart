import 'package:flutter/material.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/hexagon_icon_button.dart';
import 'package:genesis/src/theming/palette.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.color333333,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // todo: вынести в типографику
                  Text(
                    project.name,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    project.description,
                    style: TextStyle(color: Colors.white, fontSize: 14),
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
