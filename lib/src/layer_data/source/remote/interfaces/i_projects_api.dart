import 'package:genesis/src/layer_data/dtos/project_dto.dart';
import 'package:genesis/src/layer_data/requests/get_projects_req.dart';
import 'package:genesis/src/layer_data/requests/projects/create_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/delete_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/edit_project_req.dart';

abstract interface class IProjectsApi {
  /// Creates a new project.
  Future<ProjectDto> createProject(CreateProjectReq req);

  Future<ProjectDto> editProject(EditProjectReq req);

  Future<void> deleteProject(DeleteProjectReq req);

  Future<List<ProjectDto>> getProjects(GetProjectsReq req);
}
