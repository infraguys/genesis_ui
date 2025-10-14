import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/repositories/i_nodes_repository.dart';

final class DeleteNodeUseCase {
  DeleteNodeUseCase(this._repository);

  final INodesRepository _repository;

  Future<void> call(NodeID id) async {
    await _repository.deleteNode(id);
  }
}
