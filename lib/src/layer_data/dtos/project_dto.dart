import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_dto.g.dart';

@JsonSerializable(createToJson: false, constructor: '_')
class ProjectDto implements IDto<Project> {
  ProjectDto._({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.organization,
  });

  factory ProjectDto.fromJson(Map<String, dynamic> json) => _$ProjectDtoFromJson(json);

  final String uuid;
  final String name;
  final String description;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime updatedAt;
  final ProjectStatusDto status;
  @JsonKey(fromJson: _fromUrlToUuid)
  final String organization;

  static String _fromUrlToUuid(String value) => value.split('/').last;

  @override
  Project toEntity() {
    return Project(
      uuid: uuid,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status.toProjectStatus(),
      organizationUuid: organization,
    );
  }
}

@JsonEnum()
enum ProjectStatusDto {
  @JsonValue('NEW')
  newProject,
  @JsonValue('ACTIVE')
  active,
  @JsonValue('IN_PROGRESS')
  inProgress;

  ProjectStatus toProjectStatus() => switch (this) {
    newProject => ProjectStatus.newProject,
    ProjectStatusDto.active => ProjectStatus.active,
    ProjectStatusDto.inProgress => ProjectStatus.inProgress,
  };
}
