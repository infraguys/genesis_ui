part of 'project_bloc.dart';

sealed class ProjectEvent {
  factory ProjectEvent.create({
    required String userUuid,
    required String name,
    required String description,
    required String organization,
  }) = _CreateEvent;

  factory ProjectEvent.delete(String projectUuid) = _DeleteEvent;

  factory ProjectEvent.edit({
    required String uuid,
    required String organizationUuid,
    String? name,
    String? description,
    ProjectStatus? status,
  }) = _EditEvent;
}

final class _CreateEvent implements ProjectEvent {
  _CreateEvent({
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

final class _DeleteEvent implements ProjectEvent {
  _DeleteEvent(this.uuid);

  final String uuid;
}

final class _EditEvent implements ProjectEvent {
  _EditEvent({
    required this.uuid,
    required this.organizationUuid,
    this.name,
    this.description,
    this.status,
  });

  final String uuid;
  final String? name;
  final String? description;
  final String organizationUuid;
  final ProjectStatus? status;
}
