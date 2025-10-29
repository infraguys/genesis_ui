import 'package:genesis/src/features/projects/domain/entities/project.dart';

final class UpdateProjectParams {
  const UpdateProjectParams({
    required this.id,
    required this.name,
    required this.organizationLink,
    this.status,
    this.description,
  });

  final ProjectID id;
  final String name;
  final String? description;
  final String organizationLink;
  final ProjectStatus? status;
}
