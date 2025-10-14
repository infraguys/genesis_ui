import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';

final class EditProjectParams {
  const EditProjectParams({
    required this.uuid,
    required this.name,
    required this.organizationUUID,
    required this.status,
    this.description,
  });

  final ProjectID uuid;
  final String name;
  final String? description;
  final OrganizationUUID organizationUUID;
  final ProjectStatus? status;
}
