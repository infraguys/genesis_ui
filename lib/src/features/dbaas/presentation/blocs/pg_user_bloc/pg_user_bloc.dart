import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/create_pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/update_pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/pg_user_usecases/create_pg_user_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/pg_user_usecases/delete_pg_user_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/pg_user_usecases/get_pg_user_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/pg_user_usecases/update_pg_user_usecase.dart';

part 'pg_user_event.dart';
part 'pg_user_state.dart';

class PgUserBloc extends Bloc<PgUserEvent, PgUserState> {
  PgUserBloc(this._repository) : super(_Initial()) {
    on(_onCreatePgUser);
    on(_onGetPgUser);
    on(_onUpdatePgUser);
    on(_onDeletePgUser);
  }

  final IPgUsersRepository _repository;

  Future<void> _onCreatePgUser(_CreatePgUser event, Emitter<PgUserState> emit) async {
    final useCase = CreatePgUserUseCase(_repository);
    final pgUser = await useCase(event.params);
    emit(PgUserCreatedState(pgUser));
  }

  Future<void> _onGetPgUser(_GetPgUser event, Emitter<PgUserState> emit) async {
    final useCase = GetPgUserUseCase(_repository);
    emit(PgUserLoadingState());
    final pgUser = await useCase(event.params);
    emit(PgUserLoadedState(pgUser));
  }

  Future<void> _onUpdatePgUser(_UpdatePgUser event, Emitter<PgUserState> emit) async {
    final useCase = UpdatePgUserUseCase(_repository);
    final pgUser = await useCase(event.params);
    emit(PgUserUpdatedState(pgUser));
  }

  Future<void> _onDeletePgUser(_DeletePgUser event, Emitter<PgUserState> emit) async {
    final useCase = DeletePgUserUseCase(_repository);
    try {
      await useCase(event.params);
      emit(PgUserDeletedState(event.pgUser));
    } on PermissionException catch (_) {
      // emit(NodePermissionFailureState(e.message));
    }
  }
}
