import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';

abstract class NodesEndpoints {
  static const _nodes = '${Env.apiPrefix}/${Env.versionApi}/nodes/';
  static const _node = '$_nodes:id';

  static String getNodes() => _nodes;

  static String createNode() => _nodes;

  static String getNode(NodeID id) => _node.fillUuid(id);

  static String updateNode(NodeID id) => _node.fillUuid(id);

  static String deleteNode(NodeID id) => _node.fillUuid(id);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(NodeID id) => replaceFirst(':id', id.value);
}
