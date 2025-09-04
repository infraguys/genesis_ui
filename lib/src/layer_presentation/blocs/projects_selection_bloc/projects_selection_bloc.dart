import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';

part 'projects_selection_event.dart';

class ProjectsSelectionBloc extends Bloc<ProjectsSelectionEvent, List<Project>> {
  ProjectsSelectionBloc() : super(List.empty()) {
    on(_onToggle);
    on(_onToggleAll);
    on(_onClear);
  }

  void _onToggle(_Toggle event, Emitter<List<Project>> emit) {
    final updatedProjects = List.of(state);
    if (updatedProjects.contains(event.project)) {
      updatedProjects.remove(event.project);
    } else {
      updatedProjects.add(event.project);
    }
    emit(updatedProjects);
  }

  void _onToggleAll(_ToggleAll event, Emitter<List<Project>> emit) {
    if (state.length == event.projects.length) {
      emit(List.empty());
    } else {
      emit(event.projects);
    }
  }

  void _onClear(_Clear event, Emitter<List<Project>> emit) {
    emit(List.empty());
  }
}
