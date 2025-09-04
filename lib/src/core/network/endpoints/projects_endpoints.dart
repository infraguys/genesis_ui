abstract class ProjectsEndpoints {
  static const _projects = '/iam/projects/';
  static const _project = '/iam/projects/:uuid';

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
