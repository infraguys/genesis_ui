import 'package:genesis/src/layer_data/requests/get_projects_req.dart';
import 'package:genesis/src/layer_data/requests/projects/create_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/update_project_req.dart';
import 'package:genesis/src/layer_data/requests/role_bindings/create_role_binding_req.dart';
import 'package:genesis/src/layer_data/source/remote/i_projects_api.dart';
import 'package:genesis/src/layer_data/source/remote/i_role_bindings_api.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/projects/create_project_params.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/create_role_binding_params.dart';
import 'package:genesis/src/layer_domain/params/update_project_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class ProjectsRepository implements IProjectsRepository {
  ProjectsRepository(this._projectsApi, this._roleBindingsApi);

  final IProjectsApi _projectsApi;
  final IRoleBindingsApi _roleBindingsApi;

  @override
  Future<Project> createProject(CreateProjectParams params) async {
    final req = CreateProjectReq(params);
    final projectDto = await _projectsApi.createProject(req);

    final createRoleBindingReq = CreateRoleBindingReq(
      CreateRoleBindingParams(
        userUuid: params.userUuid,
        roleUuid: '726f6c65-0000-0000-0000-000000000002',
        projectUuid: projectDto.uuid,
      ),
    );
    await _roleBindingsApi.createRoleBinding(createRoleBindingReq);

    return projectDto.toEntity();
  }

  @override
  Future<void> deleteProject(String projectUuid) async {
    await _projectsApi.deleteProject(projectUuid);
  }

  @override
  Future<Project> updateProject(UpdateProjectParams params) async {
    final req = UpdateProjectReq(params);
    final dto = await _projectsApi.updateProject(req);
    return dto.toEntity();
  }

  @override
  Future<List<Project>> getProjects(params) async {
    final req = GetProjectsReq(params);
    final dtos = await _projectsApi.getProjects(req);
    return dtos.map((it) => it.toEntity()).toList();
  }
}
