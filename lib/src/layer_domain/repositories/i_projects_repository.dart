import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/get_projects_params.dart';
import 'package:genesis/src/layer_domain/params/projects/create_project_params.dart';
import 'package:genesis/src/layer_domain/params/update_project_params.dart';

abstract interface class IProjectsRepository {
  Future<Project> createProject(CreateProjectParams params);

  Future<void> deleteProject(String projectUuid);

  Future<Project> updateProject(UpdateProjectParams params);

  Future<List<Project>> getProjects(GetProjectsParams params);
}
