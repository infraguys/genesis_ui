part of 'pg_users_bloc.dart';

sealed class PgUsersState {}

final class _Initial extends PgUsersState {}

final class PgUsersLoadingState extends PgUsersState {}

final class PgUsersLoadedState extends PgUsersState {
  PgUsersLoadedState(this.pgUsers);

  final List<PgUser> pgUsers;
}

final class PgUsersCreatedState extends PgUsersState {
  PgUsersCreatedState(this.pgUser);

  final PgUser pgUser;
}
