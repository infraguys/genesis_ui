import 'package:genesis/src/core/extensions/nullable_extension.dart';
import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/projects/update_project_params.dart';

final class UpdateProjectReq implements JsonEncodable, PathEncodable {
  UpdateProjectReq(this._params);

  final UpdateProjectParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': ?_params.description,
      'status': ?_fromStatus(_params.status),
      'organization': ?_params.organizationUuid.notNull((it) => '/v1/iam/organizations/$it'),
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
  String toPath(String prefix) {
    return '$prefix/${_params.uuid}';
  }
}
