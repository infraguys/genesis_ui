part of 'project_bloc.dart';

sealed class ProjectEvent {
  factory ProjectEvent.getProject(ProjectUUID uuid) = _GetProject;

  factory ProjectEvent.create({
    required String name,
    required String description,
    required Organization organization,
    required User? user,
    required List<Role> roles,
  }) = _Create;

  factory ProjectEvent.delete(ProjectUUID projectUuid) = _Delete;

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
    required this.user,
    required this.name,
    required this.description,
    required this.organization,
    required this.roles,
  });

  final String name;
  final String description;
  final Organization organization;
  final User? user;
  final List<Role> roles;
}

final class _Delete implements ProjectEvent {
  _Delete(this.uuid);

  final ProjectUUID uuid;
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

  final ProjectUUID uuid;
}
