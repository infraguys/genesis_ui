import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';

final class DeleteProjectReq implements PathEncodable {
  DeleteProjectReq(this._uuid);

  final ProjectUUID _uuid;

  @override
  String toPath() {
    return ProjectsEndpoints.deleteProject(_uuid);
  }
}
