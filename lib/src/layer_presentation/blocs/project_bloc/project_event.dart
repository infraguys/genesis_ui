part of 'project_bloc.dart';

sealed class ProjectEvent {
  factory ProjectEvent.getProject(ProjectUUID uuid) = _GetProject;

  factory ProjectEvent.create({
    required String name,
    required String description,
    required OrganizationUUID organizationUUID,
    required UserUUID? userUUID,
    required List<Role> roles,
  }) = _Create;

  factory ProjectEvent.delete(ProjectUUID projectUuid) = _Delete;

  factory ProjectEvent.update({
    required ProjectUUID uuid,
    required OrganizationUUID organizationUUID,
    required String name,
    String? description,
    ProjectStatus? status,
  }) = _Update;
}

final class _Create implements ProjectEvent {
  _Create({
    required this.userUUID,
    required this.name,
    required this.description,
    required this.organizationUUID,
    required this.roles,
  });

  final String name;
  final String description;
  final OrganizationUUID organizationUUID;
  final UserUUID? userUUID;
  final List<Role> roles;
}

final class _Delete implements ProjectEvent {
  _Delete(this.uuid);

  final ProjectUUID uuid;
}

final class _Update implements ProjectEvent {
  _Update({
    required this.uuid,
    required this.organizationUUID,
    required this.name,
    this.description,
    this.status,
  });

  final ProjectUUID uuid;
  final OrganizationUUID organizationUUID;
  final String name;
  final String? description;
  final ProjectStatus? status;
}

final class _GetProject implements ProjectEvent {
  _GetProject(this.uuid);

  final ProjectUUID uuid;
}
