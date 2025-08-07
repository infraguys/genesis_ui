import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_label.dart';

class ProjectsListItem extends StatelessWidget {
  const ProjectsListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final project = context.read<Project>();

    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: Theme.of(context).listTileTheme.copyWith(
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.zero,
          tileColor: Colors.transparent,
        ),
      ),
      child: ListTile(
        title: Row(
          spacing: 48,
          children: [
            Expanded(flex: 2, child: Text(project.name)),
            Flexible(child: StatusLabel(status: Status.active)),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(project.uuid),
                  IconButton(
                    icon: Icon(Icons.copy, color: Colors.white, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: project.uuid));
                      final snack = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Скопировано в буфер обмена: ${project.uuid}'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  ),
                ],
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
        leading: Checkbox(
          value: false,
          onChanged: (val) {},
        ),
        onTap: () {
          // final user = context.read<User>();
          // context.goNamed(
          //   AppRoutes.user.name,
          //   pathParameters: {'uuid': user.uuid},
          //   extra: (extra: user, breadcrumbs: [user.username]),
          // );
        },
      ),
    );
  }
}
