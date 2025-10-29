import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';
import 'package:genesis/src/features/nodes/data/requests/node_type_json_mixin.dart';
import 'package:genesis/src/features/nodes/domain/params/create_node_params.dart';

final class CreateNodeReq with NodeTypeJsonMixin {
  CreateNodeReq(this._params);

  final CreateNodeParams _params;

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
    return NodesEndpoints.items().fullPath;
  }
}
