part of 'pg_users_bloc.dart';

sealed class PgUsersEvent {
  PgUsersEvent();

  factory PgUsersEvent.getUsers(GetPgUsersParams params) = _GetUsers;

  factory PgUsersEvent.deleteUsers({required List<PgUser> pgUsers, required ClusterID clusterId}) = _DeletePgUsers;
}

final class _GetUsers extends PgUsersEvent {
  _GetUsers(this.params);

  final GetPgUsersParams params;
}

final class _DeletePgUsers extends PgUsersEvent {
  _DeletePgUsers({required this.pgUsers, required this.clusterId});

  final List<PgUser> pgUsers;
  final ClusterID clusterId;
}
