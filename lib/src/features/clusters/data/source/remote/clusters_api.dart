import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/clusters/data/dtos/cluster_dto.dart';
import 'package:genesis/src/features/clusters/data/requests/cluster_req.dart';
import 'package:genesis/src/features/clusters/data/requests/create_cluster_req.dart';
import 'package:genesis/src/features/clusters/data/requests/get_clusters_req.dart';
import 'package:genesis/src/features/clusters/data/requests/update_cluster_req.dart';

final class ClustersApi {
  ClustersApi(this._client);

  final RestClient _client;

  /// Single instance methods
  ///
  /// Методы для работы с одним экземпляром

  Future<ClusterDto> getCluster(ClusterReq req) async {
    try {
      final Response(:data) = await _client.get<Map<String, dynamic>>(
        req.path,
      );
      return ClusterDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<void> deleteCluster(ClusterReq req) async {
    try {
      await _client.delete<void>(
        req.path,
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<ClusterDto> createCluster(CreateClusterReq req) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        req.path,
        data: req.body,
      );
      return ClusterDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<ClusterDto> updateCluster(UpdateClusterReq req) async {
    try {
      final Response(:data) = await _client.put<Map<String, dynamic>>(
        req.path,
        data: req.body,
      );
      return ClusterDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  /// Multiple instances methods
  ///
  /// Методы для работы с несколькими экземплярами

  Future<List<ClusterDto>> getClusters(GetClustersReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.path,
        queryParameters: req.query,
      );
      if (data == null) {
        return List.empty();
      }
      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => ClusterDto.fromJson(it)).toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
