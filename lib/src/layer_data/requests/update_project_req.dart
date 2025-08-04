import 'package:genesis/src/layer_data/requests/project_status_req.dart';
import 'package:genesis/src/layer_domain/params/update_project_paramas.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_project_req.g.dart';

@JsonSerializable(createFactory: false)
final class UpdateProjectReq {
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

  Map<String, dynamic> toJson() => _$UpdateProjectReqToJson(this);
}
