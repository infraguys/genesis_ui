import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/layer_domain/params/projects/get_project_params.dart';

final class GetProjectReq implements PathEncodable {
  GetProjectReq(this._params);

  final GetProjectParams _params;

  @override
  String toPath() {
    return ProjectsEndpoints.getProject(_params.uuid);
  }
}
