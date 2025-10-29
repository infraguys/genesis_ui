import 'package:genesis/src/features/projects/data/requests/create_project_req.dart';
import 'package:genesis/src/features/projects/data/requests/delete_project_req.dart';
import 'package:genesis/src/features/projects/data/requests/get_project_req.dart';
import 'package:genesis/src/features/projects/data/requests/get_projects_req.dart';
import 'package:genesis/src/features/projects/data/requests/update_project_req.dart';
import 'package:genesis/src/features/projects/data/sources/projects_api.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';

final class ProjectsRepository implements IProjectsRepository {
  ProjectsRepository(this._projectsApi);

  final ProjectsApi _projectsApi;

  @override
  Future<Project> createProject(params) async {
    final projectDto = await _projectsApi.createProject(CreateProjectReq(params));
    return projectDto.toEntity();
  }

  @override
  Future<void> deleteProject(uuid) async {
    await _projectsApi.deleteProject(DeleteProjectReq(uuid));
  }

  @override
  Future<Project> updateProject(params) async {
    final req = UpdateProjectReq(params);
    final dto = await _projectsApi.editProject(req);
    return dto.toEntity();
  }

  @override
  Future<Project> getProject(uuid) async {
    final dto = await _projectsApi.getProject(GetProjectReq(uuid));
    return dto.toEntity();
  }

  @override
  Future<List<Project>> getProjects(params) async {
    final dtos = await _projectsApi.getProjects(GetProjectsReq(params));
    return dtos.map((it) => it.toEntity()).toList();
  }
}
