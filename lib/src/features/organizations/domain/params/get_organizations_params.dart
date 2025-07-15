import 'package:genesis/src/features/common/shared_entities/organization.dart';

final class GetOrganizationsParams {
  GetOrganizationsParams({
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final OrganizationStatus status;

  @override
  String toString() {
    return '''
GetOrganizationsParams(
  name: $name,
  description: $description,
  createdAt: $createdAt,
  updatedAt: $updatedAt,
  status: $status,
)''';
  }
}
