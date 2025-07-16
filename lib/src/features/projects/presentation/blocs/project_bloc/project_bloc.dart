import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/create_project_params.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/projects/domain/use_cases/create_project_usecase.dart';
import 'package:genesis/src/features/projects/domain/use_cases/delete_project_usecase.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc(this._projectsRepository) : super(ProjectInitialState()) {
    on(_onCreateProject);
    on(_onDeleteProject);
  }

  final IProjectsRepository _projectsRepository;

  Future<void> _onCreateProject(_CreateProjectEvent event, Emitter<ProjectState> emit) async {
    final createProjectUseCase = CreateProjectUseCase(_projectsRepository);
    emit(ProjectInitialState());

    final createdProject = await createProjectUseCase(
      CreateProjectParams(
        name: event.name,
        description: event.description,
        organizationID: event.organization,
      ),
    );
    emit(ProjectCreatedState(createdProject));
  }

  Future<void> _onDeleteProject(_DeleteProjectEvent event, Emitter<ProjectState> emit) async {
    final useCase = DeleteProjectUseCase(_projectsRepository);
    emit(ProjectLoadingState());
    await useCase(event.projectUuid);
    emit(ProjectDeletedState());
  }
}
