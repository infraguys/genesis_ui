import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/params/nodes_params/get_nodes_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/nodes_usecases/delete_nodes_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/nodes_usecases/get_nodes_usecase.dart';

part 'nodes_event.dart';
part 'nodes_state.dart';

class NodesBloc extends Bloc<NodesEvent, NodesState> {
  NodesBloc(this._repository) : super(NodesState.initial()) {
    on(_onGetNodes);
    on(_onDeleteNodes);
  }

  final INodesRepository _repository;

  Future<void> _onGetNodes(_GetNodes event, Emitter<NodesState> emit) async {
    final useCase = GetNodesUseCase(_repository);
    emit(NodesState.loading());
    final nodes = await useCase(event._params);
    emit(NodesState.loaded(nodes));
  }

  Future<void> _onDeleteNodes(_DeleteNodes event, Emitter<NodesState> emit) async {
    final useCase = DeleteNodesUseCase(_repository);
    emit(NodesState.loading());
    await useCase(event.nodes);
    emit(NodesState.deleted());
    add(NodesEvent.getNodes());
  }
}
