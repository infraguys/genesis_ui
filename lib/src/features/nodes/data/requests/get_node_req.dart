import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';

final class GetNodeReq extends IRequest {
  GetNodeReq(this._id);

  final NodeID _id;

  @override
  String get path {
    return NodesEndpoints.item(_id).fullPath;
  }
}
