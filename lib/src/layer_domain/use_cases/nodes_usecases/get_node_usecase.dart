import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/repositories/i_nodes_repository.dart';

final class GetNodeUseCase {
  GetNodeUseCase(this._repository);

  final INodesRepository _repository;

  Future<Node> call(NodeID id) async {
    return await _repository.getNode(id);
  }
}
