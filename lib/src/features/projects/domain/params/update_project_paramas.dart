import 'package:genesis/src/features/projects/domain/entities/project.dart';

final class UpdateProjectParams {
  const UpdateProjectParams({
    required this.uuid,
    required this.name,
    required this.description,
    required this.organization,
    required this.status,
  });

  final String uuid;
  final String name;
  final String description;
  final String organization;
  final ProjectStatus status;

  @override
  String toString() {
    return '''
UpdateProjectParams(
  id: $uuid, 
  name: $name, 
  description: $description, 
  organizationId: $organization, 
  status: $status
)''';
  }
}
