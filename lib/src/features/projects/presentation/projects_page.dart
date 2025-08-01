import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/common/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/features/projects/presentation/blocs/auth_user_projects_bloc/auth_user_projects_bloc.dart';
import 'package:genesis/src/features/projects/presentation/blocs/project_bloc/project_bloc.dart';
import 'package:genesis/src/features/projects/presentation/widgets/add_project_card_button.dart';
import 'package:genesis/src/features/projects/presentation/widgets/project_action_popup_menu_button.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  late final AuthenticatedAuthState authState;

  @override
  void initState() {
    authState = context.read<AuthBloc>().state as AuthenticatedAuthState;
    context.read<AuthUserProjectsBloc>().add(AuthUserProjectsEvent.getProjects(authState.user.uuid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectDeletedState || state is ProjectUpdatedState) {
          context.read<AuthUserProjectsBloc>().add(AuthUserProjectsEvent.getProjects(authState.user.uuid));
        }
      },
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Breadcrumbs(
            items: [
              BreadcrumbItem(text: 'projects'),
            ],
          ),
          Text('Проекты', style: textTheme.headlineMedium),
          BlocBuilder<AuthUserProjectsBloc, AuthUserProjectsState>(
            builder: (context, state) {
              if (state is! AuthUserProjectsLoadedState) {
                return Expanded(child: Center(child: CupertinoActivityIndicator()));
              }
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 320,
                  mainAxisExtent: 250,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: state.projects.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return AddProjectCardButton();
                  }
                  final project = state.projects[index - 1];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                project.name,
                                style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Provider.value(
                                value: project,
                                child: ProjectActionPopupMenuButton(),
                              ),
                            ],
                          ),
                          Text(project.createdAt.toString(), style: textTheme.bodySmall),
                          Text(project.description, style: textTheme.bodySmall),
                          SizedBox(height: 16),
                          Text(
                            context.$.role(3),
                            style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
