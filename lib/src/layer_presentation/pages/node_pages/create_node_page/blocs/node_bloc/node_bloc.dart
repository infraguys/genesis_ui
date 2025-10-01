import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/params/nodes_params/create_node_params.dart';
import 'package:genesis/src/layer_domain/params/nodes_params/update_node_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/nodes_usecases/create_node_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/nodes_usecases/delete_node_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/nodes_usecases/get_node_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/nodes_usecases/update_node_usecase.dart';

part 'node_event.dart';
part 'node_state.dart';

class NodeBloc extends Bloc<NodeEvent, NodeState> {
  NodeBloc(this._repository) : super(NodeState.initial()) {
    on(_onGetNode);
    on(_onCreateNode);
    on(_onDeleteNode);
    on(_onUpdateNode);
  }

  final INodesRepository _repository;

  Future<void> _onGetNode(_GetNode event, Emitter<NodeState> emit) async {
    final useCase = GetNodeUseCase(_repository);
    emit(NodeState.loading());
    final node = await useCase(event.uuid);
    emit(NodeState.loaded(node));
  }

  Future<void> _onCreateNode(_CreateNode event, Emitter<NodeState> emit) async {
    final useCase = CreateNodeUseCase(_repository);
    try {
      final node = await useCase(event.params);
      emit(NodeState.created(node));
    } on PermissionException catch (e) {
      emit(NodePermissionFailureState(e.message));
    }
  }

  Future<void> _onDeleteNode(_DeleteNode event, Emitter<NodeState> emit) async {
    final useCase = DeleteNodeUseCase(_repository);
    try {
      await useCase(event.node.uuid);
      emit(NodeState.deleted(event.node));
    } on PermissionException catch (e) {
      emit(NodePermissionFailureState(e.message));
    }
  }

  Future<void> _onUpdateNode(_UpdateNode event, Emitter<NodeState> emit) async {
    final useCase = UpdateNodeUseCase(_repository);
    try {
      final node = await useCase(event.params);
      emit(NodeState.updated(node));
    } on PermissionException catch (e) {
      emit(NodePermissionFailureState(e.message));
    }
  }
}
