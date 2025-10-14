import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/repositories/i_nodes_repository.dart';

final class DeleteNodesUseCase {
  DeleteNodesUseCase(this._repository);

  final INodesRepository _repository;

  Future<void> call(List<Node> nodes) async {
    await Future.wait(
      nodes.map((node) => _repository.deleteNode(node.id)),
    );
  }
}
