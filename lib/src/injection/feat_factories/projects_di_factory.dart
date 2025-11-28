import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/projects/data/repositories/projects_repository.dart';
import 'package:genesis/src/features/projects/data/sources/projects_api.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';

final class ProjectsDiFactory {
  /// Repositories

  IProjectsRepository createProjectsRepository(BuildContext context) {
    final projectsApi = ProjectsApi(context.read<RestClient>());
    return ProjectsRepository(projectsApi);
  }

  /// Blocs

  ProjectsBloc createProjectsBloc(BuildContext context) {
    final repository = context.read<IProjectsRepository>();
    return ProjectsBloc(repository);
  }
}
