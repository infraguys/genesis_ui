import 'package:genesis/src/features/nodes/data/requests/create_node_req.dart';
import 'package:genesis/src/features/nodes/data/requests/delete_node_req.dart';
import 'package:genesis/src/features/nodes/data/requests/get_node_req.dart';
import 'package:genesis/src/features/nodes/data/requests/get_nodes_req.dart';
import 'package:genesis/src/features/nodes/data/requests/update_node_req.dart';
import 'package:genesis/src/features/nodes/data/sources/nodes_api.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';

final class NodesRepository implements INodesRepository {
  NodesRepository(this._client);

  final NodesApi _client;

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
