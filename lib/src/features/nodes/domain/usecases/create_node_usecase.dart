import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/nodes/domain/params/create_node_params.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';

final class CreateNodeUseCase {
  CreateNodeUseCase(this._repository);

  final INodesRepository _repository;

  Future<Node> call(CreateNodeParams params) async {
    return await _repository.createNode(params);
  }
}
