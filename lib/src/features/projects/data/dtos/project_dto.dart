import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_dto.g.dart';

@JsonSerializable(createToJson: false, constructor: '_')
class ProjectDto implements IDto<Project> {
  ProjectDto._({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.organization,
  });

  factory ProjectDto.fromJson(Map<String, dynamic> json) => _$ProjectDtoFromJson(json);

  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProjectStatusDto status;
  final List<dynamic> organization;

  @override
  Project toEntity() {
    return Project(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status.toProjectStatus(),
      organization: organization,
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
