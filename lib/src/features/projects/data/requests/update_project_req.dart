import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/features/projects/data/requests/project_status_req.dart';
import 'package:genesis/src/features/projects/domain/params/update_project_paramas.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_project_req.g.dart';

@JsonSerializable(createFactory: false)
final class UpdateProjectReq implements IReq {
  UpdateProjectReq(UpdateProjectParams params)
    : uuid = params.uuid,
      name = params.name,
      description = params.description,
      organizationUuid = params.organizationUuid,
      status = (params.status != null) ? ProjectStatusReq.fromProjectStatus(params.status!) : null;

  @JsonKey(includeToJson: false)
  final String uuid;
  final String? name;
  final String? description;
  @JsonKey(includeToJson: false)
  final String? organizationUuid;
  final ProjectStatusReq? status;

  @override
  Map<String, dynamic> toJson() => _$UpdateProjectReqToJson(this);

  @override
  String toString() {
    return '''
UpdateProjectParams(
  id: $uuid, 
  name: $name, 
  description: $description, 
  organizationUuid: $organizationUuid, 
  status: $status
)''';
  }
}
