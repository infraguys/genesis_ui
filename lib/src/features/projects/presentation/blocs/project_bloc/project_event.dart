part of 'project_bloc.dart';

sealed class ProjectEvent {
  factory ProjectEvent.create({
    required String name,
    required String description,
    required String organization,
  }) = _CreateProjectEvent;

  factory ProjectEvent.delete(String projectUuid) = _DeleteProjectEvent;
}

final class _CreateProjectEvent implements ProjectEvent {
  _CreateProjectEvent({
    required this.name,
    required this.description,
    required this.organization,
  });

  final String name;
  final String description;
  final String organization;
}

final class _DeleteProjectEvent implements ProjectEvent {
  _DeleteProjectEvent(this.projectUuid);

  final String projectUuid;
}
