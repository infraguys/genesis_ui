import 'package:flutter/material.dart';
import 'package:genesis/src/features/projects/presentation/widgets/create_project_dialog.dart';

class AddProjectCardButton extends StatelessWidget {
  const AddProjectCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            showDialog<void>(
              context: context,
              builder: (context) => CreateProjectDialog(),
            );
          },
          child: Center(child: Icon(Icons.add)),
        ),
      ),
    );
  }
}
