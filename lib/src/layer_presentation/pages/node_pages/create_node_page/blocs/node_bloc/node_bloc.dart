import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/params/nodes_params/create_node_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/nodes_usecases/create_node_usecase.dart';

part 'node_event.dart';
part 'node_state.dart';

class NodeBloc extends Bloc<NodeEvent, NodeState> {
  NodeBloc(this._repository) : super(NodeState.initial()) {
    // on(_onGetNode);
    on(_onCreateNode);
    // on(_onDeleteNode);
    // on(_onUpdateNode);
  }

  final INodesRepository _repository;

  Future<void> _onCreateNode(_CreateNode event, Emitter<NodeState> emit) async {
    final useCase = CreateNodeUseCase(_repository);
    emit(NodeState.loading());
    final node = await useCase(event.params);
    emit(NodeState.created(node));
  }
}
