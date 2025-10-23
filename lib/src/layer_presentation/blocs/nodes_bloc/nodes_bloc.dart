import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/nodes/domain/params/get_nodes_params.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/features/nodes/domain/usecases/delete_nodes_usecase.dart';
import 'package:genesis/src/features/nodes/domain/usecases/get_nodes_usecase.dart';
import 'package:genesis/src/shared/presentation/polling_bloc_mixin.dart';

part 'nodes_event.dart';

part 'nodes_state.dart';

class NodesBloc extends Bloc<NodesEvent, NodesState> with PollingBlocMixin {
  NodesBloc(this._repository) : super(NodesInitialState()) {
    on(_onGetNodes);
    on(_onDeleteNodes);
    on(_onStartPolling);
    on(_onStopPolling);
    on(_onTick, transformer: droppable<_Tick>());
    add(NodesEvent.getNodes(GetNodesParams()));
  }

  final INodesRepository _repository;

  Future<void> _onGetNodes(_GetNodes event, Emitter<NodesState> emit) async {
    final useCase = GetNodesUseCase(_repository);
    emit(NodesLoadingState());
    final nodes = await useCase(event.params);
    emit(NodesLoadedState(nodes));
  }

  Future<void> _onDeleteNodes(_DeleteNodes event, Emitter<NodesState> emit) async {
    final useCase = DeleteNodesUseCase(_repository);
    emit(NodesLoadingState());
    await useCase(event.nodes);
    emit(NodesDeletedState());
    add(NodesEvent.getNodes(GetNodesParams()));
  }

  Future<void> _onStartPolling(_StartPolling event, Emitter<NodesState> emit) async {
    final params = GetNodesParams();
    polling.start(
      () => add(_Tick(params)),
    );
  }

  Future<void> _onTick(_Tick event, Emitter<NodesState> emit) async {
    final useCase = GetNodesUseCase(_repository);
    final nodes = await useCase(event.params);
    emit(NodesLoadedState(nodes));
  }

  void _onStopPolling(_StopPolling _, Emitter<NodesState> _) {
    polling.stop();
  }
}
