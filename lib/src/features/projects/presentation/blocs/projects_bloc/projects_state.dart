part of 'projects_bloc.dart';

sealed class ProjectsState {
  factory ProjectsState.initial() = ProjectsInitState;

  factory ProjectsState.loading() = ProjectsLoadingState;

  factory ProjectsState.loaded(List<Project> projects) = ProjectsLoadedState;
}

final class ProjectsInitState implements ProjectsState {}

final class ProjectsLoadingState implements ProjectsState {}

final class ProjectsLoadedState implements ProjectsState {
  const ProjectsLoadedState(this.projects);

  final List<Project> projects;
}
