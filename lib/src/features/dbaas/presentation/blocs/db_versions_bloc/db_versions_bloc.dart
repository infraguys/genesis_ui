import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/entities/db_version.dart';
import 'package:genesis/src/features/dbaas/domain/params/db_versions_params/get_db_versions_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_db_versions_repository.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/db_versions_usecases/get_db_versions_usecase.dart';

part 'db_versions_event.dart';
part 'db_versions_state.dart';

class DbVersionsBloc extends Bloc<DbVersionsEvent, DbVersionsState> {
  DbVersionsBloc(this._repository) : super(_InitialState()) {
    on(_onGetDbVersions);
  }

  final IDBVersionsRepository _repository;

  Future<void> _onGetDbVersions(_GetDbVersions event, Emitter<DbVersionsState> emit) async {
    final useCase = GetDbVersionsUseCase(_repository);
    emit(DbVersionsLoadingState());
    final versions = await useCase(event.params);
    emit(DbVersionsLoadedState(versions));
  }
}
