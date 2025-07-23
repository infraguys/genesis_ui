import 'package:genesis/src/features/projects/domain/entities/project.dart';

final class CreateProjectParams {
  const CreateProjectParams({
    required this.userUuid,
    required this.name,
    required this.description,
    required this.organizationUuid,
  });

  final String userUuid;
  final String name;
  final String description;
  final String organizationUuid;
  final ProjectStatus status = ProjectStatus.newProject;

  @override
  String toString() {
    return '''
CreateProjectParams(
  name: $name,
  description: $description,
  organizationUuid: $organizationUuid,
  status: $status
)''';
  }
}
