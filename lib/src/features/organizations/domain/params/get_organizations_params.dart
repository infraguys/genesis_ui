import 'package:genesis/src/features/common/shared_entities/status.dart';

final class GetOrganizationsParams {
  GetOrganizationsParams({
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
  final Status? status;

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
