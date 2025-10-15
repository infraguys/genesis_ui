import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_selection_bloc/projects_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/project_pages/project_list_page/widgets/projects_table.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/create_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

part './widgets/create_project_btn.dart';
part './widgets/delete_projects_btn.dart';

class _ProjectListView extends StatelessWidget {
  const _ProjectListView();

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
            _DeleteProjectsButton(),
            _CreateProjectButton(),
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

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectsSelectionBloc(),
      child: _ProjectListView(),
    );
  }
}
