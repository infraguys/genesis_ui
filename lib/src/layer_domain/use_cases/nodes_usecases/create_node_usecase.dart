import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/params/nodes_params/create_node_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_nodes_repository.dart';

final class CreateNodeUseCase {
  CreateNodeUseCase(this._repository);

  final INodesRepository _repository;

  Future<Node> call(CreateNodeParams params) async {
    return await _repository.createNode(params);
  }
}
