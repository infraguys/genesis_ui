import 'package:genesis/src/layer_data/requests/projects/create_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/delete_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/edit_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/get_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/get_projects_req.dart';
import 'package:genesis/src/layer_data/source/remote/projects_api/projects_api.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

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
  Future<Project> editProject(params) async {
    final req = EditProjectReq(params);
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
