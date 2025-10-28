import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/create_database_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/update_database_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/database_usecases/create_database_usecase.dart';

part 'database_event.dart';

part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseBloc(this._repository) : super(_Initial()) {
    on(_onCreateDatabase);
  }

  final IDatabaseRepository _repository;

  Future<void> _onCreateDatabase(_CreateDatabase event, Emitter<DatabaseState> emit) async {
    final useCase = CreateDatabaseUseCase(_repository);
    emit(DatabaseLoadingState());
    final database = await useCase(event.params);
    // final currentDatabases = List.of((state as DatabaseLoadedState).databases)..add(database);
    emit(DatabaseCreatedState(database));
    // emit(DatabaseLoadedState(currentDatabases));
  }
}
