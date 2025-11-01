part of 'pg_user_bloc.dart';

sealed class PgUserEvent {
  PgUserEvent();

  factory PgUserEvent.create(CreatePgUserParams params) = _CreatePgUser;

  factory PgUserEvent.update(UpdatePgUserParams params) = _UpdatePgUser;

  factory PgUserEvent.delete({required PgUser pgUser, required PgUserParams params}) = _DeletePgUser;

  factory PgUserEvent.get(PgUserParams params) = _GetPgUser;
}

final class _CreatePgUser extends PgUserEvent {
  _CreatePgUser(this.params);

  final CreatePgUserParams params;
}

final class _UpdatePgUser extends PgUserEvent {
  _UpdatePgUser(this.params);

  final UpdatePgUserParams params;
}

final class _GetPgUser extends PgUserEvent {
  _GetPgUser(this.params);

  final PgUserParams params;
}

final class _DeletePgUser extends PgUserEvent {
  _DeletePgUser({
    required this.params,
    required this.pgUser,
  });

  final PgUserParams params;
  final PgUser pgUser;
}
