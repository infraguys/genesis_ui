import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/project_dto.dart';
import 'package:genesis/src/layer_data/dtos/roles_bindings.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_projects_api.dart';

final class ProjectsApi implements IProjectsApi {
  ProjectsApi(this._client);

  final RestClient _client;

  static const _roleBindingsUrl = '/v1/iam/role_bindings/';

  @override
  Future<ProjectDto> createProject(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
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
  Future<void> deleteProject(req) async {
    try {
      await _client.delete<void>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<List<ProjectDto>> getProjects(req) async {
    const url = _roleBindingsUrl;

    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        url,
        queryParameters: req.toQuery(),
      );
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        final bindings = castedData.map((it) => RolesBindingDto.fromJson(it)).toList();

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
  Future<ProjectDto> editProject(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.put<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      if (data != null) {
        return ProjectDto.fromJson(data);
      }
      throw DataNotFoundException(requestOptions.uri.path);
    } on DioException catch (e) {
      throw NetworkException(e);
    } /**/
  }
}
