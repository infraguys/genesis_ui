import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/params/nodes_params/get_nodes_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_nodes_repository.dart';

final class GetNodesUseCase {
  GetNodesUseCase(this._repository);

  final INodesRepository _repository;

  Future<List<Node>> call(GetNodesParams params) {
    return _repository.getNodes(params);
  }
}
