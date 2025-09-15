import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/repositories/i_nodes_repository.dart';

final class GetNodeUseCase {
  GetNodeUseCase(this._repository);

  final INodesRepository _repository;

  Future<Node> call(NodeUUID uuid) async {
    return await _repository.getNode(uuid);
  }
}
