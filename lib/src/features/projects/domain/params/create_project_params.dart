import 'package:genesis/src/features/projects/domain/entities/project.dart';

final class CreateProjectParams {
  const CreateProjectParams({
    required this.name,
    required this.description,
    required this.organizationID,
  });

  final String name;
  final String description;
  final String organizationID;
  final ProjectStatus status = ProjectStatus.newProject;

  @override
  String toString() {
    return '''
CreateProjectParams(
  name: $name,
  description: $description,
  organizationId: $organizationID,
  status: $status
)''';
  }
}
