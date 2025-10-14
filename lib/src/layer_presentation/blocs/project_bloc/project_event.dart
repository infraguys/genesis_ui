part of 'project_bloc.dart';

sealed class ProjectEvent {
  factory ProjectEvent.getProject(ProjectID uuid) = _GetProject;

  factory ProjectEvent.create({
    required String name,
    required String description,
    required OrganizationID organizationID,
    required UserUUID? userID,
    required List<Role> roles,
  }) = _Create;

  factory ProjectEvent.delete(Project project) = _Delete;

  factory ProjectEvent.update({
    required ProjectID projectID,
    required OrganizationID organizationID,
    required String name,
    String? description,
    ProjectStatus? status,
  }) = _Update;
}

final class _Create implements ProjectEvent {
  _Create({
    required this.userID,
    required this.name,
    required this.description,
    required this.organizationID,
    required this.roles,
  });

  final String name;
  final String description;
  final OrganizationID organizationID;
  final UserUUID? userID;
  final List<Role> roles;
}

final class _Delete implements ProjectEvent {
  _Delete(this.project);

  final Project project;
}

final class _Update implements ProjectEvent {
  _Update({
    required this.projectID,
    required this.organizationID,
    required this.name,
    this.description,
    this.status,
  });

  final ProjectID projectID;
  final OrganizationID organizationID;
  final String name;
  final String? description;
  final ProjectStatus? status;
}

final class _GetProject implements ProjectEvent {
  _GetProject(this.uuid);

  final ProjectID uuid;
}
