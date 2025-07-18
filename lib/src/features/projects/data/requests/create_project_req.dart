import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/create_project_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_project_req.g.dart';

@JsonSerializable(createFactory: false, constructor: '_')
final class CreateProjectReq implements IReq {
  factory CreateProjectReq(CreateProjectParams params) {
    return CreateProjectReq._(
      name: params.name,
      description: params.description,
      organizationID: params.organizationID,
      status: ProjectStatusReq.fromProjectStatus(params.status),
    );
  }

  CreateProjectReq._({
    required this.name,
    required this.description,
    required this.organizationID,
    this.status,
  });

  @override
  Map<String, dynamic> toJson() => _$CreateProjectReqToJson(this);

  final String name;
  final String description;
  @JsonKey(includeToJson: false)
  final String organizationID;
  @JsonKey(defaultValue: 'NEW')
  final ProjectStatusReq? status;
}

@JsonEnum()
enum ProjectStatusReq {
  // todo: remove this  status
  @JsonValue('NEW')
  newProject;

  factory ProjectStatusReq.fromProjectStatus(ProjectStatus status) {
    return switch (status) {
      ProjectStatus.newProject => ProjectStatusReq.newProject,
      // Add other cases as needed
    };
  }
}
