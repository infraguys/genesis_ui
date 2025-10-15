import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/features/projects/domain/params/get_projects_params.dart';

final class GetProjectsReq implements PathEncodable, QueryEncodable {
  const GetProjectsReq([this._params = const GetProjectsParams()]);

  final GetProjectsParams _params;

  @override
  Map<String, dynamic> toQuery() {
    return {
      'uuid': ?_params.uuids,
      'name': ?_params.name,
    };
  }

  @override
  String toPath() {
    return ProjectsEndpoints.getProjects();
  }
}
