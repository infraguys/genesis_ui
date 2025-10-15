import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/edit_project_params.dart';

final class EditProjectReq implements JsonEncodable, PathEncodable {
  EditProjectReq(this._params);

  final EditProjectParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': ?_params.description,
      'organization': OrganizationsEndpoints.getOrganization(
        _params.organizationID,
      ).replaceFirst('${Env.apiPrefix}/', ''),
      'status': ?_fromStatus(_params.status),
    };
  }

  String? _fromStatus(ProjectStatus? status) {
    return switch (status) {
      ProjectStatus.active => 'ACTIVE',
      ProjectStatus.inProgress => 'IN_PROGRESS',
      ProjectStatus.newStatus => 'NEW',
      _ => null,
    };
  }

  @override
  String toPath() {
    return ProjectsEndpoints.updateProject(_params.id);
  }
}
