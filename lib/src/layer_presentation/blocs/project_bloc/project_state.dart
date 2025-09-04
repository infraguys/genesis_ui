part of 'project_bloc.dart';

sealed class ProjectState {
  factory ProjectState.initial() = ProjectInitialState;

  factory ProjectState.loading() = ProjectLoadingState;

  factory ProjectState.loaded(Project project) = ProjectLoadedState;

  factory ProjectState.created(Project project) = ProjectCreatedState;

  factory ProjectState.updated(Project project) = ProjectUpdatedState;

  factory ProjectState.deleted() = ProjectDeletedState;

  factory ProjectState.failure(String message) = ProjectFailureState;
}

final class ProjectInitialState implements ProjectState {}

final class ProjectLoadingState implements ProjectState {}

final class ProjectLoadedState implements ProjectState {
  ProjectLoadedState(this.project);

  final Project project;
}

final class ProjectCreatedState implements ProjectState {
  ProjectCreatedState(this.project);

  final Project project;
}

final class ProjectUpdatedState implements ProjectState {
  ProjectUpdatedState(this.project);

  final Project project;
}

final class ProjectDeletedState implements ProjectState {}

final class ProjectFailureState implements ProjectState {
  ProjectFailureState(this.message);

  final String message;
}
