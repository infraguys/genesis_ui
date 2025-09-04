import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum ProjectStatusReq {
  // todo: remove this  status
  @JsonValue('NEW')
  newProject,
  @JsonValue('ACTIVE')
  active,
  @JsonValue('IN_PROGRESS')
  inProgress;

  factory ProjectStatusReq.fromProjectStatus(ProjectStatus status) {
    return switch (status) {
      ProjectStatus.newProject => ProjectStatusReq.newProject,
      ProjectStatus.active => ProjectStatusReq.active,
      ProjectStatus.inProgress => ProjectStatusReq.inProgress,
    };
  }
}
