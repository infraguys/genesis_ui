part of 'projects_selection_bloc.dart';

sealed class ProjectsSelectionEvent {
  factory ProjectsSelectionEvent.toggle(Project project) = _Toggle;

  factory ProjectsSelectionEvent.toggleAll(List<Project> projects) = _ToggleAll;

  factory ProjectsSelectionEvent.clear() = _Clear;
}

final class _Toggle implements ProjectsSelectionEvent {
  _Toggle(this.project);

  final Project project;
}

final class _ToggleAll implements ProjectsSelectionEvent {
  _ToggleAll(this.projects);

  final List<Project> projects;
}

final class _Clear implements ProjectsSelectionEvent {}
