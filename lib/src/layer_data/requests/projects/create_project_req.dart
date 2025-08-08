import 'package:genesis/src/core/env/endpoints.dart';
import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/layer_domain/params/projects/create_project_params.dart';

final class CreateProjectReq implements JsonEncodable, PathEncodable {
  CreateProjectReq(this._params);

  final CreateProjectParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': ?_params.description,
      'organization': OrganizationsEndpoints.getOrganizations.replaceFirst(':uuid', _params.organizationUuid),
    };
  }

  @override
  String toPath() {
    return ProjectsEndpoints.createProject;
  }
}
