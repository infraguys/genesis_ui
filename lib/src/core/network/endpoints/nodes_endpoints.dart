import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';

abstract class NodesEndpoints {
  static Endpoint items() {
    return Endpoint.withCorePrefix('/nodes/');
  }

  static Endpoint item(NodeID id) {
    return Endpoint.withCorePrefix('/nodes/$id');
  }
}
