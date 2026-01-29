import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';
import 'package:genesis/src/features/nodes/domain/params/get_nodes_params.dart';

final class GetNodesReq extends IRequest {
  const GetNodesReq(this._params);

  final GetNodesParams _params;

  @override
  Map<String, dynamic> get query {
    // TODO(Koretsky): Добавить параметров
    return {
      'uuid': ?_params.id,
      'name': ?_params.name,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
    };
  }

  @override
  String get path {
    return NodesEndpoints.items().fullPath;
  }
}
