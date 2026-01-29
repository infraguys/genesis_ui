import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';
import 'package:genesis/src/features/nodes/data/json_converters/node_type_converter.dart';
import 'package:genesis/src/features/nodes/domain/params/update_node_params.dart';

final class UpdateNodeReq extends IRequest {
  const UpdateNodeReq(this._params);

  final UpdateNodeParams _params;

  @override
  Map<String, dynamic> get body {
    return {
      'name': _params.name,
      'cores': _params.cores,
      'ram': _params.ram,
      'root_disk_size': _params.rootDiskSize,
      'image': _params.image,
      'node_type': NodeTypeConverter().toJson(_params.nodeType),
      'description': _params.description,
    };
  }

  @override
  String get path {
    return NodesEndpoints.item(_params.id).fullPath;
  }
}
