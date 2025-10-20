import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';

final class GetProjectReq implements PathEncodable {
  GetProjectReq(this._id);

  final ProjectID _id;

  @override
  String toPath() {
    return ProjectsEndpoints.item(_id).fullPath;
  }
}
