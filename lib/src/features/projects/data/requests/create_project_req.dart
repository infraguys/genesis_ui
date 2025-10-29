import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/features/projects/domain/params/create_project_params.dart';

final class CreateProjectReq {
  CreateProjectReq(this._params);

  final CreateProjectParams _params;

  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': ?_params.description,
      'organization': OrganizationsEndpoints.item(_params.organizationID).relativePath,
    };
  }

  String toPath() {
    return ProjectsEndpoints.items().fullPath;
  }
}
