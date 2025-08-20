import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/projects/get_projects_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/projects/get_projects_usecase.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc(this._projectsRepository) : super(ProjectsState.initial()) {
    on(_getProjects);
  }

  final IProjectsRepository _projectsRepository;

  Future<void> _getProjects(_GetProjects event, Emitter<ProjectsState> emit) async {
    final getProjectsUseCase = GetProjectsUseCase(_projectsRepository);
    emit(ProjectsState.loading());

    final projects = await getProjectsUseCase(event.params);
    emit(ProjectsState.loaded(projects));
  }
}
