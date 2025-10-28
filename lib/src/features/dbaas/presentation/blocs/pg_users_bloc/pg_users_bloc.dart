import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/get_pg_users_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/pg_user_usecases/get_pg_users_usecase.dart';

part 'pg_users_event.dart';

part 'pg_users_state.dart';

class PgUsersBloc extends Bloc<PgUsersEvent, PgUsersState> {
  PgUsersBloc(this._repository) : super(_Initial()) {
    on(_onGetPgUsers);
    on(_onAddPgUser);
  }

  final IPgUsersRepository _repository;

  Future<void> _onGetPgUsers(_GetPgUsers event, Emitter<PgUsersState> emit) async {
    final useCase = GetPgUsersUseCase(_repository);
    emit(PgUsersLoadingState());
    final pgUsers = await useCase(event.params);
    emit(PgUsersLoadedState(pgUsers));
  }

  Future<void> _onAddPgUser(_AddPgUser event, Emitter<PgUsersState> emit) async {
    final pgUsers = List.of((state as PgUsersLoadedState).pgUsers)..add(event.pgUser);
    emit(PgUsersLoadedState(pgUsers));
  }
}
