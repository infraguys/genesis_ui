import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/params/get_pg_instances_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/delete_pg_instances_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/get_pg_instances_usecase.dart';

part 'pg_instances_event.dart';

part 'pg_instances_state.dart';

class PgInstancesBloc extends Bloc<PgInstancesEvent, PgInstancesState> {
  PgInstancesBloc(this._repository) : super(PgInstancesInitialState()) {
    on(_onGetInstances);
    on(_onDeleteInstances);
    on(_onStartPolling);
    on(_onTick);
    on(_onStopPolling);
  }

  final IPgInstancesRepository _repository;

  Timer? _timer;

  Future<void> _onGetInstances(_GetInstances event, Emitter<PgInstancesState> emit) async {
    final useCase = GetPgInstancesUseCase(_repository);
    emit(PgInstancesLoadingState());
    final instances = await useCase(event.params);
    emit(PgInstancesLoadedState(instances));
  }

  Future<void> _onDeleteInstances(_DeleteInstances event, Emitter<PgInstancesState> emit) async {
    final useCase = DeletePgInstancesUseCase(_repository);
    emit(PgInstancesLoadingState());
    await useCase(event.instances.map((it) => it.id).toList());
    emit(PgInstancesDeletedState(event.instances));
    add(PgInstancesEvent.getInstances());
  }

  Future<void> _onStartPolling(_StartPolling e, Emitter<PgInstancesState> emit) async {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      add(_Tick());
    });
  }

  Future<void> _onTick(_Tick event, Emitter<PgInstancesState> emit) async {
    final useCase = GetPgInstancesUseCase(_repository);
    final instances = await useCase(event.params);
    emit(PgInstancesLoadedState(instances));
  }

  void _onStopPolling(_StopPolling event, Emitter<PgInstancesState> emit) {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
