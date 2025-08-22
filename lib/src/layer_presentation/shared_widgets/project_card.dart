import 'package:flutter/material.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/hexagon_icon_button.dart';
import 'package:genesis/src/theming/palette.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    required this.project,
    super.key,
  }) : _isEmpty = false,
       _onTap = null;

  const ProjectCard.empty({
    super.key,
    VoidCallback? onTap,
  }) : _isEmpty = true,
       project = null,
       _onTap = onTap;

  final bool _isEmpty;
  final Project? project;
  final VoidCallback? _onTap;

  @override
  Widget build(BuildContext context) {
    if (_isEmpty) {
      return Material(
        color: Colors.transparent,
        child: _SimpleProjectCard(
          child: InkWell(
            onTap: _onTap,
            child: Center(child: Icon(Icons.add, color: Palette.color6DCF91, size: 32)),
          ),
        ),
      );
    }
    return _SimpleProjectCard(
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

class _SimpleProjectCard extends StatelessWidget {
  const _SimpleProjectCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Palette.color333333,
      child: child,
    );
  }
}
