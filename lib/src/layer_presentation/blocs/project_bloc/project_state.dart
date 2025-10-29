part of 'project_bloc.dart';

sealed class ProjectState {}

final class ProjectInitialState implements ProjectState {}

final class ProjectLoadingState implements ProjectState {}

final class ProjectLoadedState extends _ProjectDataState {
  ProjectLoadedState(super.project);
}

final class ProjectCreatedState extends _ProjectDataState {
  ProjectCreatedState(super.project);
}

final class ProjectUpdatedState extends _ProjectDataState {
  ProjectUpdatedState(super.project);
}

final class ProjectDeletedState extends _ProjectDataState {
  ProjectDeletedState(super.project);
}

final class ProjectFailureState implements ProjectState {
  ProjectFailureState(this.message);

  final String message;
}

// // Base classes to reduce code duplication

base class _ProjectDataState implements ProjectState {
  _ProjectDataState(this.project);

  final Project project;
}
