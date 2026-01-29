import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:json_annotation/json_annotation.dart';

class ProjectStatusConverter implements JsonConverter<ProjectStatus, String?> {
  const ProjectStatusConverter();

  @override
  ProjectStatus fromJson(String? json) {
    return switch (json) {
      'NEW' => .newStatus,
      'ACTIVE' => .active,
      'IN_PROGRESS' => .inProgress,
      _ => .unknown,
    };
  }

  @override
  String? toJson(ProjectStatus? status) {
    return switch (status) {
      .newStatus => 'NEW',
      .active => 'ACTIVE',
      .inProgress => 'IN_PROGRESS',
      _ => null,
    };
  }
}
