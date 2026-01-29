import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:json_annotation/json_annotation.dart';

class ProjectIdConverter extends JsonConverter<ProjectID, String> {
  const ProjectIdConverter();

  @override
  ProjectID fromJson(String json) => ProjectID(json);

  @override
  String toJson(ProjectID object) => object.raw;
}