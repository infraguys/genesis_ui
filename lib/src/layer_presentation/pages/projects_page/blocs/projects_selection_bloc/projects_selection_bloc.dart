import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';

part 'projects_selection_event.dart';

class ProjectsSelectionBloc extends Bloc<ProjectsSelectionEvent, List<Project>> {
  ProjectsSelectionBloc() : super([]) {
    on(_onToggleProject);
    on(_onSelectAll);
    on(_onClearSelection);
  }

  void _onToggleProject(_ToggleProject event, Emitter<List<Project>> emit) {
    final updatedProjects = List.of(state);
    if (updatedProjects.contains(event.project)) {
      updatedProjects.remove(event.project);
    } else {
      updatedProjects.add(event.project);
    }
    emit(updatedProjects);
  }

  void _onSelectAll(_SelectAll event, Emitter<List<Project>> emit) {
    if (state.length == event.projects.length) {
      emit([]);
      return;
    } else {
      emit(event.projects);
    }
  }

  void _onClearSelection(_ClearSelection event, Emitter<List<Project>> emit) {
    emit(List.empty());
  }
}
