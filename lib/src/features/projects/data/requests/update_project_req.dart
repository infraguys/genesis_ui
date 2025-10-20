import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/edit_project_params.dart';

final class UpdateProjectReq {
  UpdateProjectReq(this._params);

  final UpdateProjectParams _params;

  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': ?_params.description,
      'organization': _params.organizationLink,
      'status': ?_fromStatusToJson(_params.status),
    };
  }

  String? _fromStatusToJson(ProjectStatus? status) {
    return switch (status) {
      ProjectStatus.active => 'ACTIVE',
      ProjectStatus.inProgress => 'IN_PROGRESS',
      ProjectStatus.newStatus => 'NEW',
      _ => null,
    };
  }

  String toPath() => ProjectsEndpoints.updateProject(_params.id);
}
