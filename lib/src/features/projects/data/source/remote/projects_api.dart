import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/features/projects/data/dtos/project_dto.dart';
import 'package:genesis/src/features/projects/data/dtos/roles_bindings.dart';
import 'package:genesis/src/features/projects/data/requests/create_project_req.dart';
import 'package:genesis/src/features/projects/data/source/remote/i_projects_api.dart';
import 'package:genesis/src/features/projects/domain/params/update_project_paramas.dart';

final class ProjectsApi implements IProjectsApi {
  ProjectsApi(this._client);

  final RestClient _client;

  static const _roleBindingsUrl = '/v1/iam/role_bindings/';
  static const _projectsUrl = '/v1/iam/projects/';

  @override
  Future<ProjectDto> createProject(CreateProjectReq req) async {
    const url = _projectsUrl;

    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        url,
        data: {
          // 'organization': '$_projectsUrl/${req.organizationId}',
          ...req.toJson(),
        },
      );
      if (data != null) {
        return ProjectDto.fromJson(data);
      }
      throw DataNotFoundException(requestOptions.uri.path);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<void> deleteProject(String projectUuid) async {
    final url = '$_projectsUrl/$projectUuid';
    try {
      await _client.delete<void>(url);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<List<ProjectDto>> getProjects(req) async {
    // const url = '$_roleBindingsUrl/?user=00000000-0000-0000-0000-000000000000';
    final url = '$_roleBindingsUrl/?user=${req.userUuid}';

    try {
      final Response(:data) = await _client.get<List<dynamic>>(url);
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        final bindings = castedData.map((it) => RolesBindingsDto.fromJson(it)).toList();

        final futures = <Future<Response<Map<String, dynamic>>>>[];

        for (var binding in bindings) {
          if (binding.project == null) {
            continue;
          }
          final future = _client.get<Map<String, dynamic>>(binding.project!);
          futures.add(future);
        }

        final projectData = await futures.wait;
        return projectData.map((response) {
          return ProjectDto.fromJson(response.data!);
        }).toList();
      }
    } on DioException catch (e) {
      throw NetworkException(e);
    }
    return [];
  }

  @override
  Future<void> updateProject(UpdateProjectParams params) {
    // TODO: implement updateProject
    throw UnimplementedError();
  }
}
