import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/layer_domain/params/projects/get_projects_params.dart';

final class GetProjectsReq implements PathEncodable, QueryEncodable {
  const GetProjectsReq(this.params);

  final GetProjectsParams params;

  @override
  Map<String, dynamic> toQuery() {
    return {};
  }

  @override
  String toPath() {
    return ProjectsEndpoints.getProjects();
  }
}

extension GetProjectsParamsX on GetProjectsParams {
  GetProjectsReq toReq() => GetProjectsReq(this);
}
