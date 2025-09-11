import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';

final class GetNodesReq implements PathEncodable, QueryEncodable {
  @override
  Map<String, dynamic> toQuery() {
    // TODO: implement toQuery
    throw UnimplementedError();
  }

  @override
  String toPath() {
    return NodesEndpoints.getNodes();
  }
}
