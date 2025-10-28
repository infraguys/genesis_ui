import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/get_databases_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/database_usecases/get_databases_usecase.dart';

part 'databases_event.dart';
part 'databases_state.dart';

class DatabasesBloc extends Bloc<DatabasesEvent, DatabasesState> {
  DatabasesBloc(this._repository) : super(_DatabasesInitialState()) {
    on(_onGetDatabases);
  }

  final IDatabaseRepository _repository;

  Future<void> _onGetDatabases(_GetDatabases event, Emitter<DatabasesState> emit) async {
    final useCase = GetDatabasesUseCase(_repository);
    emit(DatabasesLoadingState());
    final databases = await useCase(event.params);
    emit(DatabasesLoadedState(databases));
  }

  Future<void> _onDeleteDatabases(_DeleteDatabases event, Emitter<DatabasesState> emit) async {
    // final useCase = DeleteNodesUseCase(_repository);
    emit(DatabasesLoadingState());
    // await useCase(event.nodes);
    // emit(NodesDeletedState());
    // add(NodesEvent.getNodes(GetNodesParams()));
  }

  // Future<void> _onStartPolling(_StartPolling event, Emitter<NodesState> emit) async {
  //   final params = GetNodesParams();
  //   polling.start(
  //     () => add(_Tick(params)),
  //   );
  // }
  //
  // Future<void> _onTick(_Tick event, Emitter<NodesState> emit) async {
  //   final useCase = GetNodesUseCase(_repository);
  //   final nodes = await useCase(event.params);
  //   emit(NodesLoadedState(nodes));
  // }
  //
  // void _onStopPolling(_StopPolling _, Emitter<NodesState> _) {
  //   polling.stop();
  // }
}
