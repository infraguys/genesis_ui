import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';

abstract class NodesEndpoints {
  static const _nodes = '/${Env.versionApi}/nodes/';
  static const _node = '/${Env.versionApi}/nodes/:uuid';

  static String getNodes() => _nodes;

  static String createNode() => _nodes;

  static String getNode(NodeUUID uuid) => _node.fillUuid(uuid);

  static String updateNode(NodeUUID uuid) => _node.fillUuid(uuid);

  static String deleteNode(NodeUUID uuid) => _node.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(NodeUUID uuid) => replaceFirst(':uuid', uuid.value);
}
