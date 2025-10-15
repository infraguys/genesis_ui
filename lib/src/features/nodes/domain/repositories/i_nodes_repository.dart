import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/nodes/domain/params/create_node_params.dart';
import 'package:genesis/src/features/nodes/domain/params/get_nodes_params.dart';
import 'package:genesis/src/features/nodes/domain/params/update_node_params.dart';

abstract interface class INodesRepository {
  Future<Node> getNode(NodeID id);

  Future<List<Node>> getNodes(GetNodesParams params);

  Future<Node> createNode(CreateNodeParams params);

  Future<Node> updateNode(UpdateNodeParams params);

  Future<void> deleteNode(NodeID id);
}
