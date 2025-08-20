import 'package:genesis/src/layer_data/requests/projects/create_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/delete_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/edit_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/get_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/get_projects_req.dart';
import 'package:genesis/src/layer_data/requests/role_bindings/create_role_binding_req.dart';
import 'package:genesis/src/layer_data/requests/role_bindings/get_role_bindings_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_projects_api.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_role_bindings_api.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/create_role_binding_params.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/get_role_bindings_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class ProjectsRepository implements IProjectsRepository {
  ProjectsRepository(this._projectsApi, this._roleBindingsApi);

  final IProjectsApi _projectsApi;
  final IRoleBindingsApi _roleBindingsApi;

  @override
  Future<Project> createProject(params) async {
    final req = CreateProjectReq(params);
    final projectDto = await _projectsApi.createProject(req);

    final createRoleBindingReq = CreateRoleBindingReq(
      CreateRoleBindingParams(
        userUuid: params.userUuid,
        roleUuid: params.roleUuid,
        projectUuid: projectDto.uuid,
      ),
    );
    await _roleBindingsApi.createRoleBinding(createRoleBindingReq);

    return projectDto.toEntity();
  }

  @override
  Future<void> deleteProject(params) async {
    final req = DeleteProjectReq(params);
    await _projectsApi.deleteProject(req);
  }

  @override
  Future<Project> editProject(params) async {
    final req = EditProjectReq(params);
    final dto = await _projectsApi.editProject(req);
    return dto.toEntity();
  }

  @override
  Future<List<Project>> getProjectsByUser(params) async {
    final roleBindingsReq = GetRoleBindingsReq(
      GetRoleBindingsParams(userUuid: params.userUuid),
    );
    final roleBindingDtos = await _roleBindingsApi.getRoleBindings(roleBindingsReq);

    final projectDtos = await Future.wait(
      roleBindingDtos.where((dto) => dto.project != null).map((it) {
        final req = GetProjectReq(it.project!.split('/').last);
        return _projectsApi.getProject(req);
      }),
    );
    return projectDtos.map((it) => it.toEntity()).toList();
  }

  @override
  Future<List<Project>> getProjects(params) async {
    final dtos = await _projectsApi.getProjects(params.toReq());
    return dtos.map((it) => it.toEntity()).toList();
  }
}
