part of 'project_bloc.dart';

sealed class ProjectState {}

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
