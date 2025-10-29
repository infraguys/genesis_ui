import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/nodes/data/dtos/node_dto.dart';
import 'package:genesis/src/features/nodes/data/requests/create_node_req.dart';
import 'package:genesis/src/features/nodes/data/requests/delete_node_req.dart';
import 'package:genesis/src/features/nodes/data/requests/get_node_req.dart';
import 'package:genesis/src/features/nodes/data/requests/get_nodes_req.dart';
import 'package:genesis/src/features/nodes/data/requests/update_node_req.dart';

final class NodesApi {
  NodesApi(this._client);

  final RestClient _client;

  Future<NodeDto> createNode(CreateNodeReq req) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return NodeDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<void> deleteNode(DeleteNodeReq req) async {
    try {
      await _client.delete<void>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<NodeDto> getNode(GetNodeReq req) async {
    try {
      final Response(:data, :requestOptions) = await _client.get<Map<String, dynamic>>(
        req.toPath(),
      );
      return NodeDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<List<NodeDto>> getNodes(GetNodesReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data == null) {
        return List.empty();
      }
      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => NodeDto.fromJson(it)).toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<NodeDto> updateNode(UpdateNodeReq req) async {
    try {
      final Response(:data) = await _client.put<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return NodeDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
