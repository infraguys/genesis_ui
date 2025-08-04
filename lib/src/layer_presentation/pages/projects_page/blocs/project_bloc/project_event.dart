part of 'project_bloc.dart';

sealed class ProjectEvent {
  factory ProjectEvent.create({
    required String userUuid,
    required String name,
    required String description,
    required String organization,
  }) = _CreateProjectEvent;

  factory ProjectEvent.delete(String projectUuid) = _DeleteProjectEvent;

  factory ProjectEvent.update({
    required String uuid,
    String? name,
    String? description,
    String? organization,
    ProjectStatus? status,
  }) = _ProjectUpdateEvent;
}

final class _CreateProjectEvent implements ProjectEvent {
  _CreateProjectEvent({
    required this.userUuid,
    required this.name,
    required this.description,
    required this.organization,
  });

  final String userUuid;
  final String name;
  final String description;
  final String organization;
}

final class _DeleteProjectEvent implements ProjectEvent {
  _DeleteProjectEvent(this.projectUuid);

  final String projectUuid;
}

final class _ProjectUpdateEvent implements ProjectEvent {
  _ProjectUpdateEvent({
    required this.uuid,
    this.name,
    this.description,
    this.organization,
    this.status,
  });

  final String uuid;
  final String? name;
  final String? description;
  final String? organization;
  final ProjectStatus? status;
}
