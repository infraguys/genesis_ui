import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/get_projects_params.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/projects/domain/usecases/delete_projects_usecase.dart';
import 'package:genesis/src/features/projects/domain/usecases/get_projects_usecase.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc(this._projectsRepository) : super(ProjectsState.initial()) {
    on(_onGetProjects);
    on(_onDeleteProjects);
    add(ProjectsEvent.getProjects());
  }

  final IProjectsRepository _projectsRepository;

  Future<void> _onGetProjects(_Get event, Emitter<ProjectsState> emit) async {
    final useCase = GetProjectsUseCase(_projectsRepository);
    emit(ProjectsState.loading());

    final projects = await useCase(event.params);
    emit(ProjectsState.loaded(projects));
  }

  Future<void> _onDeleteProjects(_DeleteProjects event, Emitter<ProjectsState> emit) async {
    final useCase = DeleteProjectsUseCase(_projectsRepository);
    emit(ProjectsState.loading());

    await useCase(event.projects);
    add(ProjectsEvent.getProjects());
  }
}
