import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';

final class DeleteProjectReq {
  DeleteProjectReq(this._uuid);

  final ProjectID _uuid;

  String toPath() => ProjectsEndpoints.deleteProject(_uuid);
}
