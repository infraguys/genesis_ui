import 'package:genesis/src/layer_domain/entities/organization.dart';

final class UpdateOrganizationParams {
  const UpdateOrganizationParams({
    required this.uuid,
    this.name,
    this.description,
  });

  final OrganizationUUID uuid;
  final String? name;
  final String? description;
}
