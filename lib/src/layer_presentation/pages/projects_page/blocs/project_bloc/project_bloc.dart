import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/projects/create_project_params.dart';
import 'package:genesis/src/layer_domain/params/projects/delete_project_params.dart';
import 'package:genesis/src/layer_domain/params/projects/edit_project_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/create_project_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/delete_project_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/edit_project_usecase.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc(this._projectsRepository) : super(ProjectInitialState()) {
    on(_onCreateProject);
    on(_onDeleteProject);
    on(_onUpdateProject);
  }

  final IProjectsRepository _projectsRepository;

  Future<void> _onCreateProject(_CreateEvent event, Emitter<ProjectState> emit) async {
    final createProjectUseCase = CreateProjectUseCase(_projectsRepository);
    emit(ProjectLoadingState());

    final createdProject = await createProjectUseCase(
      CreateProjectParams(
        userUuid: event.userUuid,
        name: event.name,
        description: event.description,
        organizationUuid: event.organization,
      ),
    );
    emit(ProjectCreatedState(createdProject));
  }

  Future<void> _onDeleteProject(_DeleteEvent event, Emitter<ProjectState> emit) async {
    final useCase = DeleteProjectUseCase(_projectsRepository);
    emit(ProjectLoadingState());
    final params = DeleteProjectParams(uuid: event.uuid);
    await useCase(params);
    emit(ProjectDeletedState());
  }

  Future<void> _onUpdateProject(_EditEvent event, Emitter<ProjectState> emit) async {
    final useCase = EditProjectUseCase(_projectsRepository);
    emit(ProjectLoadingState());

    final params = EditProjectParams(
      uuid: event.uuid,
      name: event.name,
      description: event.description,
      organizationUuid: event.organizationUuid,
      status: event.status,
    );
    final updatedProject = await useCase(params);
    emit(ProjectUpdatedState(updatedProject));
  }
}
