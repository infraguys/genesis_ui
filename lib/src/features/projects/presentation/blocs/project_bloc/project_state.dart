part of 'project_bloc.dart';

sealed class ProjectState {}

final class ProjectInitialState extends ProjectState {}

final class ProjectLoadingState extends ProjectState {}

final class ProjectLoadedState extends ProjectState {
  ProjectLoadedState(this.project);

  final Project project;
}

final class ProjectCreatedState extends ProjectState {
  ProjectCreatedState(this.project);

  final Project project;
}
