import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';

final class DeleteProjectReq extends IRequest {
  const DeleteProjectReq(this._id);

  final ProjectID _id;

  @override
  String get path {
    return ProjectsEndpoints.item(_id).fullPath;
  }
}
