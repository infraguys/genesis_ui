import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/nodes_endpoints.dart';
import 'package:genesis/src/layer_domain/params/nodes_params/create_node_params.dart';

final class CreateNodeReq implements PathEncodable, JsonEncodable {
  CreateNodeReq(this._params);

  final CreateNodeParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'cores': _params.cores,
      'ram': _params.cores,
      'root_disk_size': _params.rootDiskSize,
      'image': _params.image,
      // 'node_type': ,
      'description': ?_params.description,
      'project_id': 'f9a747f9-bb35-4c35-b627-fd81f9107eaa',
    };
  }

  @override
  String toPath() {
    return NodesEndpoints.createNode();
  }
}
