import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';
import 'package:genesis/src/features/nodes/data/requests/node_type_json_mixin.dart';
import 'package:genesis/src/features/nodes/domain/params/update_node_params.dart';

final class UpdateNodeReq with NodeTypeJsonMixin {
  UpdateNodeReq(this._params);

  final UpdateNodeParams _params;

  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'cores': _params.cores,
      'ram': _params.ram,
      'root_disk_size': _params.rootDiskSize,
      'image': _params.image,
      'node_type': fromNodeTypeToJson(_params.nodeType),
      'description': _params.description,
    };
  }

  String toPath() {
    return NodesEndpoints.item(_params.id).fullPath;
  }
}
