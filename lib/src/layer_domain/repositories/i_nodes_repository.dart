import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/params/nodes_params/get_nodes_params.dart';

abstract interface class INodesRepository {
  Future<Node> getNode(NodeUUID uuid);

  Future<List<Node>> getNodes(GetNodesParams params);

  Future<Node> createNode();

  Future<Node> updateNode(NodeUUID uuid);

  Future<void> deleteNode(NodeUUID uuid);
}
