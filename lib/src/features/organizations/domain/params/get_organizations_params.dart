import 'package:genesis/src/features/organizations/domain/entities/organization.dart';

final class GetOrganizationsParams {
  const GetOrganizationsParams({
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final OrganizationStatus? status;
}
