import 'package:genesis/src/core/env/env.dart';

abstract class ProjectsEndpoints {
  static const String _projects = '/${Env.versionApi}/iam/projects/';
  static const String _project = '/${Env.versionApi}/iam/projects/:uuid';

  static const String getProjects = _projects;
  static const String createProject = _projects;
  static const String getProject = _project;
  static const String updateProject = _project;
  static const String deleteProject = _project;
}
