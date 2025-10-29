import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';

final class DeleteProjectReq {
  DeleteProjectReq(this._id);

  final ProjectID _id;

  String toPath() {
    return ProjectsEndpoints.item(_id).fullPath;
  }
}
