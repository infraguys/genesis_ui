import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/projects/create_project_params.dart';
import 'package:genesis/src/layer_domain/params/projects/edit_project_params.dart';
import 'package:genesis/src/layer_domain/params/projects/get_projects_params.dart';

abstract interface class IProjectsRepository {
  Future<Project> createProject(CreateProjectParams params);

  Future<void> deleteProject(ProjectID uuid);

  Future<Project> editProject(EditProjectParams params);

  Future<Project> getProject(ProjectID uuid);

  Future<List<Project>> getProjects(GetProjectsParams params);
}
