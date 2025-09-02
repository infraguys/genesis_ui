import 'package:equatable/equatable.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';

class Project extends Equatable {
  const Project({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.organizationUUID,
  });

  final ProjectUUID uuid;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProjectStatus status;
  final OrganizationUUID organizationUUID;

  @override
  List<Object?> get props => [
    uuid,
    name,
    description,
    createdAt,
    updatedAt,
    status,
    organizationUUID,
  ];
}

enum ProjectStatus {
  newProject,
  active,
  inProgress,
}

extension type ProjectUUID(String value) {}
