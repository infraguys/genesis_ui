import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/get_pg_users_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/pg_user_usecases/delete_pg_users_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/pg_user_usecases/get_pg_users_usecase.dart';

part 'pg_users_event.dart';

part 'pg_users_state.dart';

class PgUsersBloc extends Bloc<PgUsersEvent, PgUsersState> {
  PgUsersBloc(this._repository) : super(_Initial()) {
    on(_onGetPgUsers);
    on(_onDeletePgUsers);
  }

  final IPgUsersRepository _repository;

  Future<void> _onGetPgUsers(_GetUsers event, Emitter<PgUsersState> emit) async {
    final useCase = GetPgUsersUseCase(_repository);
    emit(PgUsersLoadingState());
    final pgUsers = await useCase(event.params);
    emit(PgUsersLoadedState(pgUsers));
  }

  Future<void> _onDeletePgUsers(_DeletePgUsers event, Emitter<PgUsersState> emit) async {
    final useCase = DeletePgUsersUseCase(_repository);
    emit(PgUsersLoadingState());
    final listOfParams = event.pgUsers.map((it) {
      return PgUserParams(pgUserId: it.id, clusterId: event.clusterId);
    }).toList();
    await useCase(listOfParams);
    emit(PgUsersDeletedState(event.pgUsers));
    add(PgUsersEvent.getUsers(GetPgUsersParams(clusterId: event.clusterId)));
  }
}
