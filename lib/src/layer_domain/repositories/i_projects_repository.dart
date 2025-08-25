import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/projects/create_project_params.dart';
import 'package:genesis/src/layer_domain/params/projects/delete_project_params.dart';
import 'package:genesis/src/layer_domain/params/projects/edit_project_params.dart';
import 'package:genesis/src/layer_domain/params/projects/get_projects_params.dart';

abstract interface class IProjectsRepository {
  Future<Project> createProject(CreateProjectParams params);

  Future<void> deleteProject(DeleteProjectParams params);

  Future<Project> editProject(EditProjectParams params);

  Future<List<({Project project, List<Role> roles})>> getProjectsByUser(GetProjectsParams params);

  Future<List<Project>> getProjects(GetProjectsParams params);
}
