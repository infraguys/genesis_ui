import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/nodes/domain/params/get_nodes_params.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';

final class GetNodesUseCase {
  GetNodesUseCase(this._repository);

  final INodesRepository _repository;

  Future<List<Node>> call(GetNodesParams params) {
    return _repository.getNodes(params);
  }
}
