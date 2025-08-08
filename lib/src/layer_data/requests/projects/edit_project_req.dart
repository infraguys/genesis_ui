import 'package:genesis/src/core/env/endpoints.dart';
import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/projects/edit_project_params.dart';

final class EditProjectReq implements JsonEncodable, PathEncodable {
  EditProjectReq(this._params);

  final EditProjectParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': ?_params.description,
      'organization': OrganizationsEndpoints.getOrganization.replaceFirst(':uuid', _params.organizationUuid),
      'status': ?_fromStatus(_params.status),
    };
  }

  String? _fromStatus(ProjectStatus? status) {
    return switch (status) {
      ProjectStatus.active => 'ACTIVE',
      ProjectStatus.inProgress => 'IN_PROGRESS',
      ProjectStatus.newProject => 'NEW',
      _ => null,
    };
  }

  @override
  String toPath() {
    return ProjectsEndpoints.editProject.replaceFirst(':uuid', _params.uuid);
  }
}
