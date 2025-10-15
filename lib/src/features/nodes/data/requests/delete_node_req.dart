import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';

final class DeleteNodeReq implements PathEncodable {
  DeleteNodeReq(this._id);

  final NodeID _id;

  @override
  String toPath() {
    return NodesEndpoints.deleteNode(_id);
  }
}
