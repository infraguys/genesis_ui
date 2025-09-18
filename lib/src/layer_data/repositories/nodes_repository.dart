import 'package:genesis/src/layer_data/requests/node_requests/create_node_req.dart';
import 'package:genesis/src/layer_data/requests/node_requests/delete_node_req.dart';
import 'package:genesis/src/layer_data/requests/node_requests/get_node_req.dart';
import 'package:genesis/src/layer_data/requests/node_requests/get_nodes_req.dart';
import 'package:genesis/src/layer_data/requests/node_requests/update_node_req.dart';
import 'package:genesis/src/layer_data/source/remote/nodes_api/i_nodes_api.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/repositories/i_nodes_repository.dart';

final class NodesRepository implements INodesRepository {
  NodesRepository(this._client);

  final INodesApi _client;

  @override
  Future<Node> createNode(params) async {
    final dto = await _client.createNode(CreateNodeReq(params));
    return dto.toEntity();
  }

  @override
  Future<void> deleteNode(uuid) async {
    await _client.deleteNode(DeleteNodeReq(uuid));
  }

  @override
  Future<Node> getNode(uuid) async {
    final dto = await _client.getNode(GetNodeReq(uuid));
    return dto.toEntity();
  }

  @override
  Future<List<Node>> getNodes(params) async {
    final dtos = await _client.getNodes(GetNodesReq(params));
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Node> updateNode(params) async {
    final dto = await _client.updateNode(UpdateNodeReq(params));
    return dto.toEntity();
  }
}
