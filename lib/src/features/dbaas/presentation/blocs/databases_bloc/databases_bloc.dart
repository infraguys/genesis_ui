import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/database_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/get_databases_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/database_usecases/delete_databases_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/database_usecases/get_databases_usecase.dart';
import 'package:genesis/src/shared/presentation/polling_bloc_mixin.dart';

part 'databases_event.dart';
part 'databases_state.dart';

class DatabasesBloc extends Bloc<DatabasesEvent, DatabasesState> with PollingBlocMixin {
  DatabasesBloc(this._repository) : super(_DatabasesInitialState()) {
    on(_onGetDatabases);
    on(_onDeleteDatabases);
    on(_onStartPolling);
    on(_onTick, transformer: droppable<_Tick>());
    on(_onStopPolling);
  }

  final IDatabaseRepository _repository;

  Future<void> _onGetDatabases(_GetDatabases event, Emitter<DatabasesState> emit) async {
    final useCase = GetDatabasesUseCase(_repository);
    emit(DatabasesLoadingState());
    final databases = await useCase(event.params);
    emit(DatabasesLoadedState(databases));
  }

  Future<void> _onDeleteDatabases(_DeleteDatabases event, Emitter<DatabasesState> emit) async {
    final useCase = DeleteDatabasesUseCase(_repository);
    final listOfParams = event.databases
        .map((it) => DatabaseParams(clusterId: event.clusterId, databaseId: it.id))
        .toList();
    await useCase(listOfParams);
    final newListOfPgDatabases = List.of((state as DatabasesLoadedState).databases)
      ..removeWhere((db) => event.databases.contains(db));
    emit(DatabasesDeletedState(event.databases));
    emit(DatabasesLoadedState(newListOfPgDatabases));
  }

  Future<void> _onStartPolling(_StartPolling event, Emitter<DatabasesState> emit) async {
    final params = GetDatabasesParams(clusterId: event.clusterId);
    polling.start(
      () => add(_Tick(params)),
    );
  }

  Future<void> _onTick(_Tick event, Emitter<DatabasesState> emit) async {
    final useCase = GetDatabasesUseCase(_repository);
    final databases = await useCase(event.params);
    emit(DatabasesLoadedState(databases));
  }

  void _onStopPolling(_StopPolling _, Emitter<DatabasesState> _) {
    polling.stop();
  }
}
