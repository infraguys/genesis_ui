import 'package:genesis/src/features/projects/data/requests/create_project_req.dart';
import 'package:genesis/src/features/projects/data/requests/get_projects_req.dart';
import 'package:genesis/src/features/projects/data/source/remote/i_projects_api.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/create_project_params.dart';
import 'package:genesis/src/features/projects/domain/params/update_project_paramas.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';

final class ProjectsRepository implements IProjectsRepository {
  ProjectsRepository(this._projectsApi);

  final IProjectsApi _projectsApi;

  @override
  Future<Project> createProject(CreateProjectParams params) async {
    final req = CreateProjectReq(params);
    final dto = await _projectsApi.createProject(req);
    return dto.toEntity();
  }

  @override
  Future<void> deleteProject(String uuid) {
    // TODO: implement deleteProject
    throw UnimplementedError();
  }

  @override
  Future<Project> updateProject(UpdateProjectParams params) {
    // TODO: implement updateProject
    throw UnimplementedError();
  }

  @override
  Future<List<Project>> getProjects(params) async {
    final req = GetProjectsReq(params);
    final dtos = await _projectsApi.getProjects(req);
    return dtos.map((it) => it.toEntity()).toList();
  }
}
