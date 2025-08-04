import 'package:genesis/src/layer_data/dtos/project_dto.dart';
import 'package:genesis/src/layer_data/requests/create_project_req.dart';
import 'package:genesis/src/layer_data/requests/get_projects_req.dart';
import 'package:genesis/src/layer_data/requests/update_project_req.dart';

abstract interface class IProjectsApi {
  /// Creates a new project.
  Future<ProjectDto> createProject(CreateProjectReq req);

  Future<ProjectDto> updateProject(UpdateProjectReq req);

  Future<void> deleteProject(String projectUuid);

  Future<List<ProjectDto>> getProjects(GetProjectsReq req);
}
