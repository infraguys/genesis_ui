import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/features/projects/domain/params/get_projects_params.dart';

final class GetProjectsReq extends IRequest {
  const GetProjectsReq(this._params);

  final GetProjectsParams _params;

  @override
  Map<String, dynamic> get query {
    return {
      'uuid': ?_params.uuids,
      'name': ?_params.name,
    };
  }

  @override
  String get path {
    return ProjectsEndpoints.items().fullPath;
  }
}
