import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_selection_bloc/projects_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/widgets/delete_projects_elevated_button.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/widgets/projects_create_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/widgets/projects_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';

class _ProjectsView extends StatelessWidget {
  const _ProjectsView();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Breadcrumbs(
          items: [
            BreadcrumbItem(text: context.$.projects),
          ],
        ),
        ButtonsBar.withoutLeftSpacer(
          children: [
            // SearchInput(),
            Spacer(),
            DeleteProjectsElevatedButton(),
            ProjectsCreateIconButton(),
          ],
        ),
        Expanded(
          child: BlocConsumer<ProjectsBloc, ProjectsState>(
            listenWhen: (_, current) => current is ProjectsLoadedState,
            listener: (context, state) {
              context.read<ProjectsSelectionBloc>().add(ProjectsSelectionEvent.clear());
            },
            builder: (_, state) => switch (state) {
              ProjectsLoadedState(:final projects) => ProjectsTable(projects: projects),
              _ => AppProgressIndicator(),
            },
          ),
        ),
      ],
    );
  }
}

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectsSelectionBloc(),
      child: _ProjectsView(),
    );
  }
}
