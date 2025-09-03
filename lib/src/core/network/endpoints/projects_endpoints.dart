import 'package:genesis/src/core/env/env.dart';

abstract class ProjectsEndpoints {
  static final _projects = '/${Env.versionApi}/iam/projects/';
  static final _project = '/${Env.versionApi}/iam/projects/:uuid';

  static String getProjects() => _projects;

  static String createProject() => _projects;

  static String getProject(String uuid) => _project.fillUuid(uuid);

  static String updateProject(String uuid) => _project.fillUuid(uuid);

  static String deleteProject(String uuid) => _project.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(String uuid) => replaceFirst(':uuid', uuid);
}
