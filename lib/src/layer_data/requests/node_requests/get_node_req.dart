import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';

final class GetNodeReq implements PathEncodable {
  GetNodeReq(this.uuid);

  final NodeUUID uuid;

  @override
  String toPath() {
    return NodesEndpoints.getNode(uuid);
  }
}
