import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/features/projects/domain/params/create_project_params.dart';

final class CreateProjectReq extends IRequest {
  const CreateProjectReq(this._params);

  final CreateProjectParams _params;

  @override
  Map<String, dynamic> get body {
    return {
      'name': _params.name,
      'description': ?_params.description,
      'organization': OrganizationsEndpoints.item(_params.organizationID).relativePath,
    };
  }

  @override
  String get path {
    return ProjectsEndpoints.items().fullPath;
  }
}
