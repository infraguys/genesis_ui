import 'package:genesis/src/layer_data/requests/projects/create_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/delete_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/edit_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/get_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/get_projects_req.dart';
import 'package:genesis/src/layer_data/requests/role_bindings/get_role_bindings_req.dart';
import 'package:genesis/src/layer_data/requests/roles/get_role_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_projects_api.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_role_bindings_api.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_roles_api.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/get_role_bindings_params.dart';
import 'package:genesis/src/layer_domain/params/roles/get_role_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class ProjectsRepository implements IProjectsRepository {
  ProjectsRepository(this._projectsApi, this._roleBindingsApi, this._rolesApi);

  final IProjectsApi _projectsApi;
  final IRoleBindingsApi _roleBindingsApi;
  final IRolesApi _rolesApi;

  @override
  Future<Project> createProject(params) async {
    final projectDto = await _projectsApi.createProject(CreateProjectReq(params));
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
  Future<List<({Project project, List<Role> roles})>> getProjectsByUser(params) async {
    final roleBindingsReq = GetRoleBindingsReq(GetRoleBindingsParams(userUuid: params.userUuid));
    final roleBindingDtos = await _roleBindingsApi.getRoleBindings(roleBindingsReq);

    // todo: нужен рефакторинг

    final List<({Project project, List<Role> roles})> result = [];

    String projectId = '';
    for (var binding in roleBindingDtos) {
      if (binding.project == null) {
        continue;
      } else if (projectId == binding.project!.split('/').last) {
        continue;
      }

      projectId = binding.project!.split('/').last;
      final projectDto = await _projectsApi.getProject(GetProjectReq(projectId));
      final project = projectDto.toEntity();
      final rolesDto = await Future.wait(
        roleBindingDtos.where((it) => it.project!.split('/').last == projectId).map(
          (e) {
            return _rolesApi.getRole(GetRoleReq(GetRoleParams(uuid: e.role.split('/').last)));
          },
        ),
      );

      final roles = rolesDto.map((it) => it.toEntity()).toList();
      result.add((project: project, roles: roles));
    }

    return result;
  }

  @override
  Future<List<Project>> getProjects(params) async {
    final dtos = await _projectsApi.getProjects(params.toReq());
    return dtos.map((it) => it.toEntity()).toList();
  }
}
