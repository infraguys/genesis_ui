abstract class NodesEndpoints {
  static const _nodes = '/nodes/';
  static const _node = '/nodes/:uuid';

  static String getNodes() => _nodes;

  static String createNode() => _nodes;

  static String getNode(String uuid) => _node.fillUuid(uuid);

  static String updateNode(String uuid) => _node.fillUuid(uuid);

  static String deleteNode(String uuid) => _node.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(String uuid) => replaceFirst(':uuid', uuid);
}
