import 'package:genesis/src/layer_data/requests/node_requests/create_node_req.dart';
import 'package:genesis/src/layer_data/requests/node_requests/get_nodes_req.dart';
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
  Future<void> deleteNode(uuid) {
    // TODO: implement deleteNode
    throw UnimplementedError();
  }

  @override
  Future<Node> getNode(uuid) {
    // TODO: implement getNode
    throw UnimplementedError();
  }

  @override
  Future<List<Node>> getNodes(params) async {
    final dtos = await _client.getNodes(GetNodesReq(params));
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Node> updateNode(uuid) {
    // TODO: implement updateNode
    throw UnimplementedError();
  }
}
