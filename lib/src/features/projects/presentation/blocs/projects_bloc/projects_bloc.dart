import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/projects/domain/use_cases/get_projects_usecase.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc(this._projectsRepository) : super(ProjectsInitialState()) {
    on(_getProjects);
  }

  final IProjectsRepository _projectsRepository;

  Future<void> _getProjects(_GetProjectsEvent event, Emitter<ProjectsState> emit) async {
    final getProjectsUseCase = GetProjectsUseCase(_projectsRepository);
    emit(ProjectsLoadingState());
    final projects = await getProjectsUseCase();
    emit(ProjectsLoadedState(projects));
  }
}
