import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_dto.g.dart';

@JsonSerializable(constructor: '_')
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

  @JsonKey(name: 'uuid', fromJson: _toID)
  final ProjectID id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'status', fromJson: _toStatusFromJson)
  final ProjectStatus status;
  @JsonKey(name: 'organization', fromJson: _fromUrlToUuid)
  final String organization;

  @override
  Project toEntity() {
    return Project(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      organizationID: OrganizationID(organization),
    );
  }

  static ProjectID _toID(String json) => ProjectID(json);

  static String _fromUrlToUuid(String value) => value.split('/').last;

  static ProjectStatus _toStatusFromJson(String json) => switch (json) {
    'NEW' => ProjectStatus.newStatus,
    'ACTIVE' => ProjectStatus.active,
    'IN_PROGRESS' => ProjectStatus.inProgress,
    _ => ProjectStatus.unknown,
  };
}
