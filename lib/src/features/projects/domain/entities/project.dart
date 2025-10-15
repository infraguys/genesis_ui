import 'package:equatable/equatable.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';

class Project extends Equatable {
  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.organizationID,
  });

  final ProjectID id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProjectStatus status;
  final OrganizationID organizationID;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    createdAt,
    updatedAt,
    status,
    organizationID,
  ];
}

enum ProjectStatus { newStatus, active, inProgress, unknown }

extension type ProjectID(String value) {
  bool isEqual(ProjectID other) => value == other.value;
}
