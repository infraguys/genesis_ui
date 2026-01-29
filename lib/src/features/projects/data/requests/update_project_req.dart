import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/features/projects/data/json_converters/project_status_converter.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/edit_project_params.dart';

final class UpdateProjectReq extends IRequest {
  const UpdateProjectReq(this._params);

  final UpdateProjectParams _params;

  @override
  Map<String, dynamic> get body {
    return {
      'name': _params.name,
      'description': ?_params.description,
      'organization': _params.organizationLink,
      'status': ?ProjectStatusConverter().toJson(_params.status),
    };
  }

  @override
  String get path {
    return ProjectsEndpoints.item(_params.id).fullPath;
  }
}
