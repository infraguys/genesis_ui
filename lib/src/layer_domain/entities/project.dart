import 'package:equatable/equatable.dart';

class Project extends Equatable {
  const Project({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.organizationUuid,
  });

  final ProjectUUID uuid;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProjectStatus status;
  final String organizationUuid;

  @override
  List<Object?> get props => [
    uuid,
    name,
    description,
    createdAt,
    updatedAt,
    status,
    organizationUuid,
  ];
}

enum ProjectStatus {
  newProject,
  active,
  inProgress,
}

extension type ProjectUUID(String value) {}
