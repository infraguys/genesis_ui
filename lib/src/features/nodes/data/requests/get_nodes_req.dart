import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';
import 'package:genesis/src/features/nodes/domain/params/get_nodes_params.dart';

final class GetNodesReq {
  GetNodesReq(this._params);

  final GetNodesParams _params;

  Map<String, dynamic> toQuery() {
    // TODO(Koretsky): Добавить параметров
    return {
      'uuid': ?_params.id,
      'name': ?_params.name,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
    };
  }

  String toPath() {
    return NodesEndpoints.items().fullPath;
  }
}
