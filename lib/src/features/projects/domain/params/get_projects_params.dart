import 'package:genesis/src/features/projects/domain/entities/project.dart';

final class GetProjectsParams {
  const GetProjectsParams({
    this.uuids,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.organization,
  });

  final List<ProjectID>? uuids;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? organization;
}
