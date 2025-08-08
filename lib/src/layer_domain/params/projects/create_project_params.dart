import 'package:genesis/src/layer_domain/entities/project.dart';

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
}
