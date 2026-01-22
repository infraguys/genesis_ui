import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/projects/data/repositories/projects_repository.dart';
import 'package:genesis/src/features/projects/data/sources/projects_api.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:genesis/src/features/projects/domain/usecases/delete_project_usecase.dart';
import 'package:genesis/src/features/projects/domain/usecases/delete_projects_usecase.dart';
import 'package:genesis/src/features/projects/domain/usecases/get_project_usecase.dart';
import 'package:genesis/src/features/projects/domain/usecases/get_projects_usecase.dart';
import 'package:genesis/src/features/projects/domain/usecases/update_project_usecase.dart';
import 'package:genesis/src/features/projects/presentation/blocs/project_bloc/project_bloc.dart';
import 'package:genesis/src/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/features/projects/presentation/blocs/projects_selection_cubit/projects_selection_cubit.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';

final class ProjectsDiFactory {
  /// Repositories
  ///
  IProjectsRepository makeProjectsRepository(BuildContext context) {
    final projectsApi = ProjectsApi(context.read<RestClient>());
    return ProjectsRepository(projectsApi);
  }

  /// Blocs
  ///
  ProjectsBloc makeProjectsBloc(BuildContext context) {
    final repository = context.read<IProjectsRepository>();
    return ProjectsBloc(
      getProjectsUseCase: GetProjectsUseCase(repository),
      deleteProjectsUseCase: DeleteProjectsUseCase(repository),
    );
  }

  ProjectBloc makeProjectBloc(BuildContext context) {
    final repository = context.read<IProjectsRepository>();
    final roleBindingsRepository = context.read<IRoleBindingsRepository>();
    return ProjectBloc(
      getProjectUseCase: GetProjectUseCase(repository),
      createProjectUseCase: CreateProjectUseCase(repository),
      updateProjectUseCase: UpdateProjectUseCase(repository),
      deleteProjectUseCase: DeleteProjectUseCase(repository),
      roleBindingsRepository: roleBindingsRepository,
    );
  }

  ProjectsSelectionCubit makeProjectsSelectionCubit(BuildContext context) {
    return ProjectsSelectionCubit();
  }
}
