import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/get_pg_instances_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/params/get_pg_instances_params.dart';

part 'pg_instances_event.dart';

part 'pg_instances_state.dart';

class PgInstancesBloc extends Bloc<PgInstancesEvent, PgInstancesState> {
  PgInstancesBloc(this._repository) : super(PgInstancesInitialState()) {
    on(_onGetInstances);
  }

  final IPgInstancesRepository _repository;

  Future<void> _onGetInstances(_GetInstances event, Emitter<PgInstancesState> emit) async {
    final useCase = GetPgInstancesUseCase(_repository);
    emit(PgInstancesLoadingState());
    final instances = await useCase(event.params);
    emit(PgInstancesLoadedState(instances));
  }
}
