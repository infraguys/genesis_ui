import 'package:genesis/src/features/projects/data/dtos/project_dto.dart';
import 'package:genesis/src/features/projects/data/requests/create_project_req.dart';
import 'package:genesis/src/features/projects/data/requests/get_projects_req.dart';
import 'package:genesis/src/features/projects/domain/params/update_project_paramas.dart';

abstract interface class IProjectsApi {
  /// Creates a new project.
  Future<ProjectDto> createProject(CreateProjectReq req);

  Future<void> updateProject(UpdateProjectParams params);

  Future<void> deleteProject(String uuid);

  Future<List<ProjectDto>> getProjects(GetProjectsReq req);
}
