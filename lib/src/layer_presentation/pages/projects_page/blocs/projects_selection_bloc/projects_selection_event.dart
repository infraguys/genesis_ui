part of 'projects_selection_bloc.dart';

sealed class ProjectsSelectionEvent {
  factory ProjectsSelectionEvent.toggleProject(Project project) = _ToggleProject;

  factory ProjectsSelectionEvent.selectAll(List<Project> projects) = _SelectAll;

  factory ProjectsSelectionEvent.clearSelection() = _ClearSelection;
}

final class _ToggleProject implements ProjectsSelectionEvent {
  _ToggleProject(this.project);

  final Project project;
}

final class _SelectAll implements ProjectsSelectionEvent {
  _SelectAll(this.projects);

  final List<Project> projects;
}

final class _ClearSelection implements ProjectsSelectionEvent {}
