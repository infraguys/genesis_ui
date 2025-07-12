part of 'projects_bloc.dart';

sealed class ProjectsState {}

final class ProjectsInitialState implements ProjectsState {}

final class ProjectsLoadingState implements ProjectsState {}

final class ProjectsLoadedState implements ProjectsState {
  ProjectsLoadedState(this.projects);

  final List<Project> projects;

  @override
  String toString() => 'ProjectsLoadedState(projects: $projects)';
}
