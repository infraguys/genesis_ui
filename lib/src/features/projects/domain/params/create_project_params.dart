import 'package:genesis/src/features/projects/domain/entities/project.dart';

final class CreateProjectParams {
  const CreateProjectParams({
    required this.name,
    required this.description,
    required this.organization,
  });

  final String name;
  final String description;
  final String organization;
  final ProjectStatus status = ProjectStatus.newProject;

  @override
  String toString() {
    return 'CreateProjectParams(name: $name, description: $description, organizationId: $organization, status: $status)';
  }
}
