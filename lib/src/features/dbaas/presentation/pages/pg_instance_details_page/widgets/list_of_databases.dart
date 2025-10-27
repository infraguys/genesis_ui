import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/add_card_button.dart';

class ListOfDatabases extends StatelessWidget {
  const ListOfDatabases({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        SizedBox(
          width: 500,
          height: 250,
          child: AddCardButton(
            onTap: () async {
              await showDialog<void>(
                context: context,
                builder: (context) => Dialog(child: Placeholder()),
              );
            },
          ),
        ),
        // for (final it in state.projectsWithRoles)
        //   SizedBox(
        //     width: 500,
        //     height: 250,
        //     child: ProjectCard(project: it.project, roles: it.roles, userUUID: userUuid),
        //   ),
      ],
    );
  }
}
