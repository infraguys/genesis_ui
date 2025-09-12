import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';
import 'package:genesis/src/layer_domain/params/nodes_params/get_nodes_params.dart';

final class GetNodesReq implements PathEncodable, QueryEncodable {
  GetNodesReq(this._params);

  final GetNodesParams _params;

  @override
  Map<String, dynamic> toQuery() {
    return {};
  }

  @override
  String toPath() {
    return NodesEndpoints.getNodes();
  }
}
