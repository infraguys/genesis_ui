import 'package:genesis/src/features/common/shared_entities/organization.dart';

final class UpdateOrganizationParams {
  const UpdateOrganizationParams({
    required this.uuid,
    required this.name,
    this.description,
    this.status,
    this.info,
  });

  final String uuid;
  final String name;
  final String? description;
  final OrganizationStatus? status;
  final Map<String, dynamic>? info;

  @override
  String toString() {
    return '''
UpdateOrganizationParams(
  uuid: $uuid,
  name: $name,
  description: $description,
  info: $info,
)''';
  }
}
