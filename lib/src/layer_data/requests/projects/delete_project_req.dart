import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/layer_domain/params/projects/delete_project_params.dart';

final class DeleteProjectReq implements PathEncodable {
  DeleteProjectReq(this._params);

  final DeleteProjectParams _params;

  @override
  String toPath() {
    return ProjectsEndpoints.deleteProject.replaceFirst(':uuid', _params.uuid);
  }
}
