import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/node_dto.dart';
import 'package:genesis/src/layer_data/requests/node_requests/create_node_req.dart';
import 'package:genesis/src/layer_data/source/remote/nodes_api/i_nodes_api.dart';

final class NodesApi implements INodesApi {
  NodesApi(this._client);

  final RestClient _client;

  @override
  Future<NodeDto> createNode(CreateNodeReq req) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        //   'name': _params.name,
        //       'cores': _params.cores,
        //       'ram': _params.ram,
        //       'root_disk_size': _params.rootDiskSize,
        //       'image': _params.image,
        //       'node_type': NodeTypeDto.of(_params.nodeType).toJson(),
        //       'description': _params.description,
        //       // 'project_id': 'f9a747f9-bb35-4c
        data: req.toJson(),
      );
      return NodeDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<void> deleteNode(req) async {
    try {
      await _client.delete<void>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<NodeDto> getNode(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.get<Map<String, dynamic>>(
        req.toPath(),
      );
      return NodeDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<List<NodeDto>> getNodes(req) async {
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

  @override
  Future<NodeDto> updateNode(req) async {
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
