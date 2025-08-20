import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/project_bloc/project_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/widgets/projects_create_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/widgets/projects_delete_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/widgets/projects_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  late final AuthenticatedAuthState authState;

  @override
  void initState() {
    context.read<ProjectsBloc>().add(
      ProjectsEvent.getProjects(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        switch (state) {
          case ProjectDeletedState():
          case ProjectUpdatedState():
            context.read<ProjectsBloc>().add(ProjectsEvent.getProjects());
          default:
        }
      },
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Breadcrumbs(
            items: [
              BreadcrumbItem(text: context.$.projects),
            ],
          ),
          Row(
            spacing: 4.0,
            children: [
              Spacer(),
              ProjectsDeleteIconButton(),
              ProjectsCreateIconButton(),
            ],
          ),
          Expanded(
            child: BlocBuilder<ProjectsBloc, ProjectsState>(
              builder: (context, state) {
                if (state is! ProjectsLoadedState) {
                  return AppProgressIndicator();
                }
                return ProjectsTable(projects: state.projects);
                //       return AddProjectCardButton();
              },
            ),
          ),
        ],
      ),
    );
  }
}
