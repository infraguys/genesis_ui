import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/params/nodes_params/update_node_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_nodes_repository.dart';

final class UpdateNodeUseCase {
  UpdateNodeUseCase(this._repository);

  final INodesRepository _repository;

  Future<Node> call(UpdateNodeParams params) async {
    return await _repository.updateNode(params);
  }
}
