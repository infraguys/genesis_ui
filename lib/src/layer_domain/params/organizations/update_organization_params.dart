import 'package:genesis/src/layer_domain/entities/organization.dart';

final class UpdateOrganizationParams {
  const UpdateOrganizationParams({
    required this.id,
    this.name,
    this.description,
  });

  final OrganizationID id;
  final String? name;
  final String? description;
}
