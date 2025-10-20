import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/params/create_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/update_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/create_pg_instance_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/delete_pg_instance_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/get_pg_instance_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/update_pg_instance_usecase.dart';

part 'pg_instance_event.dart';

part 'pg_instance_state.dart';

class PgInstanceBloc extends Bloc<PgInstanceEvent, PgInstanceState> {
  PgInstanceBloc(this._repository) : super(PgInstanceInitialState()) {
    on(_onCreateInstance);
    on(_onGetInstance);
    on(_onDeleteInstance);
    on(_onUpdatePgInstance);
  }

  final IPgInstancesRepository _repository;

  Future<void> _onGetInstance(_GetInstance event, Emitter<PgInstanceState> emit) async {
    final useCase = GetPgInstanceUseCase(_repository);
    emit(PgInstanceLoadingState());
    final instance = await useCase(event.id);
    emit(PgInstanceLoadedState(instance));
  }

  Future<void> _onCreateInstance(_CreateInstance event, Emitter<PgInstanceState> emit) async {
    final useCase = CreatePgInstanceUseCase(_repository);
    try {
      final instance = await useCase(event.params);
      emit(PgInstanceCreatedState(instance));
    } on PermissionException catch (e) {
      print(e);
      // emit(NodePermissionFailureState(e.message));
    } on ApiException catch (e) {
      emit(PgInstanceFailureState(e.message));
    } on NetworkException catch (e) {
      emit(PgInstanceFailureState(e.message));
    }
  }

  Future<void> _onDeleteInstance(_DeleteInstance event, Emitter<PgInstanceState> emit) async {
    final useCase = DeletePgInstanceUseCase(_repository);
    try {
      await useCase(event.instance.id);
      emit(PgInstanceDeletedState(event.instance));
    } on PermissionException catch (e) {
      // emit(NodePermissionFailureState(e.message));
    }
  }

  Future<void> _onUpdatePgInstance(_UpdateInstance event, Emitter<PgInstanceState> emit) async {
    final useCase = UpdatePgInstanceUseCase(_repository);
    try {
      final instance = await useCase(event.params);
      emit(PgInstanceUpdatedState(instance));
    } on PermissionException catch (e) {
      // emit(NodePermissionFailureState(e.message));
    }
  }
}
