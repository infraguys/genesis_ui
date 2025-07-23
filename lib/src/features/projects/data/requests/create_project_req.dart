import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/features/projects/data/requests/project_status_req.dart';
import 'package:genesis/src/features/projects/domain/params/create_project_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_project_req.g.dart';

@JsonSerializable(createFactory: false)
final class CreateProjectReq implements IReq {
  CreateProjectReq(CreateProjectParams params)
    : userUuid = params.userUuid,
      name = params.name,
      description = params.description,
      organizationUuid = params.organizationUuid,
      status = ProjectStatusReq.fromProjectStatus(params.status);

  @override
  Map<String, dynamic> toJson() => _$CreateProjectReqToJson(this);

  @JsonKey(includeToJson: false)
  final String userUuid;
  final String name;
  final String description;
  @JsonKey(includeToJson: false)
  final String organizationUuid;
  @JsonKey(defaultValue: 'NEW')
  final ProjectStatusReq? status;
}
