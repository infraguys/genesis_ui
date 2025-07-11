import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(createToJson: false)
class ProjectDto implements IDto<Project> {
  ProjectDto({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.organization,
  });

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
