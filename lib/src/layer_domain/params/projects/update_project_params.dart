import 'package:genesis/src/layer_domain/entities/project.dart';

final class UpdateProjectParams {
  const UpdateProjectParams({
    required this.uuid,
    required this.name,
    required this.description,
    required this.organizationUuid,
    required this.status,
  });

  final String uuid;
  final String? name;
  final String? description;
  final String? organizationUuid;
  final ProjectStatus? status;
}
