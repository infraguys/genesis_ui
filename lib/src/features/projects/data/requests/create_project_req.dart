import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/features/projects/data/requests/project_status_req.dart';
import 'package:genesis/src/features/projects/domain/params/create_project_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_project_req.g.dart';

@JsonSerializable(createFactory: false)
final class CreateProjectReq implements IReq {
  CreateProjectReq(CreateProjectParams params)
    : name = params.name,
      description = params.description,
      organizationID = params.organizationID,
      status = ProjectStatusReq.fromProjectStatus(params.status);

  @override
  Map<String, dynamic> toJson() => _$CreateProjectReqToJson(this);

  final String name;
  final String description;
  @JsonKey(includeToJson: false)
  final String organizationID;
  @JsonKey(defaultValue: 'NEW')
  final ProjectStatusReq? status;
}
