import 'package:genesis/src/layer_data/requests/projects/create_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/delete_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/edit_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/get_project_req.dart';
import 'package:genesis/src/layer_data/requests/projects/get_projects_req.dart';
import 'package:genesis/src/layer_data/source/remote/projects_api/i_projects_api.dart';
import 'package:genesis/src/layer_data/source/remote/role_bindings_api/i_role_bindings_api.dart';
import 'package:genesis/src/layer_data/source/remote/roles_api/i_roles_api.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
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
  Future<List<({Project project, List<Role> roles})>> getProjectsByUser(params) async {
    throw UnimplementedError();
    // final roleBindingsReq = GetRoleBindingsReq(GetRoleBindingsParams(userUuid: params.userUuid));
    // final roleBindingDtos = await _roleBindingsApi.getRoleBindings(roleBindingsReq);
    //
    // // todo: нужен рефакторинг
    //
    // final Set<({Project project, List<Role> roles})> result = {};
    //
    // String projectId = '';
    // for (var binding in roleBindingDtos) {
    //   if (binding.project == null) {
    //     continue;
    //   } else if (projectId == binding.project!.split('/').last) {
    //     continue;
    //   }
    //
    //   projectId = binding.project!.split('/').last;
    //   final projectDto = await _projectsApi.getProject(GetProjectReq(projectId));
    //   final project = projectDto.toEntity();
    //   final rolesDto = await Future.wait(
    //     roleBindingDtos.where((it) => it.project!.split('/').last == projectId).map(
    //       (e) {
    //         return _rolesApi.getRole(GetRoleReq(GetRoleParams(uuid: e.role.split('/').last)));
    //       },
    //     ),
    //   );
    //
    //   final roles = rolesDto.map((it) => it.toEntity()).toList();
    //   result.add((project: project, roles: roles));
    // }
    //
    // return result.toList();
  }

  @override
  Future<List<Project>> getProjects(params) async {
    final dtos = await _projectsApi.getProjects(params.toReq());
    return dtos.map((it) => it.toEntity()).toList();
  }
}
