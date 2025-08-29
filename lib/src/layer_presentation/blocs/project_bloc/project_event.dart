part of 'project_bloc.dart';

sealed class ProjectEvent {
  factory ProjectEvent.getProject(String uuid) = _GetProject;

  factory ProjectEvent.create({
    required String userUuid,
    required String name,
    required String description,
    required OrganizationUUID organizationUuid,
    required List<String> roleUuid,
  }) = _Create;

  factory ProjectEvent.delete(String projectUuid) = _Delete;

  factory ProjectEvent.update({
    required String uuid,
    required String organizationUuid,
    String? name,
    String? description,
    ProjectStatus? status,
  }) = _Update;
}

final class _Create implements ProjectEvent {
  _Create({
    required this.userUuid,
    required this.name,
    required this.description,
    required this.organizationUuid,
    required this.roleUuid,
  });

  final String userUuid;
  final String name;
  final String description;
  final OrganizationUUID organizationUuid;
  final List<String> roleUuid;
}

final class _Delete implements ProjectEvent {
  _Delete(this.uuid);

  final String uuid;
}

final class _Update implements ProjectEvent {
  _Update({
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

final class _GetProject implements ProjectEvent {
  _GetProject(this.uuid);

  final String uuid;
}
