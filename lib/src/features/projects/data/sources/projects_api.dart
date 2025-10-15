import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/projects/data/dtos/project_dto.dart';
import 'package:genesis/src/features/projects/data/requests/create_project_req.dart';
import 'package:genesis/src/features/projects/data/requests/delete_project_req.dart';
import 'package:genesis/src/features/projects/data/requests/edit_project_req.dart';
import 'package:genesis/src/features/projects/data/requests/get_project_req.dart';
import 'package:genesis/src/features/projects/data/requests/get_projects_req.dart';

final class ProjectsApi {
  ProjectsApi(this._client);

  final RestClient _client;

  Future<ProjectDto> createProject(CreateProjectReq req) async {
    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return ProjectDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<void> deleteProject(DeleteProjectReq req) async {
    try {
      await _client.delete<void>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<ProjectDto> editProject(EditProjectReq req) async {
    try {
      final Response(:data, :requestOptions) = await _client.put<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return ProjectDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<ProjectDto> getProject(GetProjectReq req) async {
    try {
      final Response(:data, :requestOptions) = await _client.get<Map<String, dynamic>>(
        req.toPath(),
      );
      return ProjectDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<List<ProjectDto>> getProjects(GetProjectsReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        return castedData.map((it) => ProjectDto.fromJson(it)).toList();
      }
      return List.empty();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
