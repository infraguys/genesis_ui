import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';

abstract class ProjectsEndpoints {
  static const _projects = '${Env.apiPrefix}/${Env.versionApi}/iam/projects/';
  static const _project = '/$_projects:id';

  static String getProjects() => _projects;

  static String createProject() => _projects;

  static String getProject(ProjectID id) => _project.fillUuid(id);

  static String updateProject(ProjectID id) => _project.fillUuid(id);

  static String deleteProject(ProjectID id) => _project.fillUuid(id);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(ProjectID uuid) => replaceFirst(':id', uuid.value);
}
