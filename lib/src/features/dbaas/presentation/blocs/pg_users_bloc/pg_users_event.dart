part of 'pg_users_bloc.dart';

sealed class PgUsersEvent {
  PgUsersEvent();

  factory PgUsersEvent.getPgUsers(GetPgUsersParams params) = _GetPgUsers;

  factory PgUsersEvent.addPgUsers(PgUser pgUser) = _AddPgUser;
}

final class _GetPgUsers extends PgUsersEvent {
  _GetPgUsers(this.params);

  final GetPgUsersParams params;
}

final class _AddPgUser extends PgUsersEvent {
  _AddPgUser(this.pgUser);

  final PgUser pgUser;
}
