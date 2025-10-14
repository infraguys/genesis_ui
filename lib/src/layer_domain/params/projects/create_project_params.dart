import 'package:genesis/src/layer_domain/entities/organization.dart';

final class CreateProjectParams {
  const CreateProjectParams({
    required this.name,
    required this.description,
    required this.organizationID,
  });

  final String name;
  final String? description;
  final OrganizationID organizationID;
}
