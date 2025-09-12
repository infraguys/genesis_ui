import 'package:genesis/src/layer_data/dtos/node_dto.dart';
import 'package:genesis/src/layer_data/requests/node_requests/create_node_req.dart';
import 'package:genesis/src/layer_data/requests/node_requests/delete_node_req.dart';
import 'package:genesis/src/layer_data/requests/node_requests/get_node_req.dart';
import 'package:genesis/src/layer_data/requests/node_requests/get_nodes_req.dart';
import 'package:genesis/src/layer_data/requests/node_requests/update_node_req.dart';

abstract interface class INodesApi {
  Future<NodeDto> getNode(GetNodeReq req);

  Future<List<NodeDto>> getNodes(GetNodesReq req);

  Future<NodeDto> createNode(CreateNodeReq req);

  Future<NodeDto> updateNode(UpdateNodeReq req);

  Future<void> deleteNode(DeleteNodeReq uuid);
}
