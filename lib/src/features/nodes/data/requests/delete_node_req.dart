import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';

final class DeleteNodeReq {
  DeleteNodeReq(this._id);

  final NodeID _id;

  String toPath() {
    return NodesEndpoints.deleteNode(_id);
  }
}
