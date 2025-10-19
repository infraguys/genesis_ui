import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';

final class GetNodeReq implements PathEncodable {
  GetNodeReq(this.id);

  final NodeID id;

  @override
  String toPath() => NodesEndpoints.getNode(id);
}
