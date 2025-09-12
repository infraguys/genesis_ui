import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';

abstract class ProjectsEndpoints {
  static const _projects = '/${Env.versionApi}/iam/projects/';
  static const _project = '/${Env.versionApi}/iam/projects/:uuid';

  static String getProjects() => _projects;

  static String createProject() => _projects;

  static String getProject(ProjectUUID uuid) => _project.fillUuid(uuid);

  static String updateProject(ProjectUUID uuid) => _project.fillUuid(uuid);

  static String deleteProject(ProjectUUID uuid) => _project.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(ProjectUUID uuid) => replaceFirst(':uuid', uuid.value);
}
