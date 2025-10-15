import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';

final class EditProjectParams {
  const EditProjectParams({
    required this.id,
    required this.name,
    required this.organizationID,
    required this.status,
    this.description,
  });

  final ProjectID id;
  final String name;
  final String? description;
  final OrganizationID organizationID;
  final ProjectStatus? status;
}
