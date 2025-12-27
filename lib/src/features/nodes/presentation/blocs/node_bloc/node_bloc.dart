import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/nodes/domain/params/create_node_params.dart';
import 'package:genesis/src/features/nodes/domain/params/update_node_params.dart';
import 'package:genesis/src/features/nodes/domain/usecases/create_node_usecase.dart';
import 'package:genesis/src/features/nodes/domain/usecases/delete_node_usecase.dart';
import 'package:genesis/src/features/nodes/domain/usecases/get_node_usecase.dart';
import 'package:genesis/src/features/nodes/domain/usecases/update_node_usecase.dart';

part './node_event.dart';

part './node_state.dart';

class NodeBloc extends Bloc<NodeEvent, NodeState> {
  NodeBloc({
    required GetNodeUseCase getNodeUseCase,
    required CreateNodeUseCase createNodeUseCase,
    required DeleteNodeUseCase deleteNodeUseCase,
    required UpdateNodeUseCase updateNodeUseCase,
  }) : _getNodeUseCase = getNodeUseCase,
       _createNodeUseCase = createNodeUseCase,
       _deleteNodeUseCase = deleteNodeUseCase,
       _updateNodeUseCase = updateNodeUseCase,
       super(_InitialState()) {
    on(_onGetNode);
    on(_onCreateNode);
    on(_onDeleteNode);
    on(_onUpdateNode);
  }

  final GetNodeUseCase _getNodeUseCase;
  final CreateNodeUseCase _createNodeUseCase;
  final DeleteNodeUseCase _deleteNodeUseCase;
  final UpdateNodeUseCase _updateNodeUseCase;

  Future<void> _onGetNode(_GetNode event, Emitter<NodeState> emit) async {
    emit(NodeLoadingState());
    final node = await _getNodeUseCase(event.id);
    emit(NodeLoadedState(node));
  }

  Future<void> _onCreateNode(_CreateNode event, Emitter<NodeState> emit) async {
    try {
      final node = await _createNodeUseCase(event.params);
      emit(NodeCreatedState(node));
    } on PermissionException catch (e) {
      emit(NodePermissionFailureState(e.message));
    }
  }

  Future<void> _onDeleteNode(_DeleteNode event, Emitter<NodeState> emit) async {
    try {
      await _deleteNodeUseCase(event.node.id);
      emit(NodeDeletedState(event.node));
    } on PermissionException catch (e) {
      emit(NodePermissionFailureState(e.message));
    }
  }

  Future<void> _onUpdateNode(_UpdateNode event, Emitter<NodeState> emit) async {
    try {
      final node = await _updateNodeUseCase(event.params);
      emit(NodeUpdatedState(node));
    } on PermissionException catch (e) {
      emit(NodePermissionFailureState(e.message));
    }
  }
}
