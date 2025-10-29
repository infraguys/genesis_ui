part of 'pg_user_bloc.dart';

sealed class PgUserState {}

final class _Initial extends PgUserState {}

final class PgUserLoadingState extends PgUserState {}

final class PgUserLoadedState extends PgUserState {
  PgUserLoadedState(this.pgUser);

  final PgUser pgUser;
}

final class PgUserUpdatedState extends PgUserState {
  PgUserUpdatedState(this.pgUser);

  final PgUser pgUser;
}

final class PgUserCreatedState extends PgUserState {
  PgUserCreatedState(this.pgUser);

  final PgUser pgUser;
}

final class PgUserDeletedState extends PgUserState {
  PgUserDeletedState(this.pgUser);

  final PgUser pgUser;
}
