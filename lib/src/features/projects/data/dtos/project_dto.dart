import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
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
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime createdAt;
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime updatedAt;
  final ProjectStatusDto status;
  final String organization;

  static DateTime _fromIsoStringToDateTime(String value) => DateTime.parse(value);

  @override
  Project toEntity() {
    return Project(
      uuid: uuid,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status.toProjectStatus(),
    );
  }
}

@JsonEnum()
enum ProjectStatusDto {
  @JsonValue('NEW')
  newProject;

  ProjectStatus toProjectStatus() => switch (this) {
    newProject => ProjectStatus.newProject,
  };
}
