import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';
import 'package:genesis/src/layer_data/dtos/node_type_dto.dart';
import 'package:genesis/src/layer_domain/params/nodes_params/update_node_params.dart';

final class UpdateNodeReq implements JsonEncodable, PathEncodable {
  UpdateNodeReq(this._params);

  final UpdateNodeParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'cores': _params.cores,
      'ram': _params.cores,
      'root_disk_size': _params.rootDiskSize,
      'image': _params.image,
      'node_type': NodeTypeDto.of(_params.nodeType).toJson(),
      'description': _params.description,
    };
  }

  @override
  String toPath() {
    return NodesEndpoints.updateNode(_params.uuid);
  }
}
