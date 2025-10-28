part of 'database_bloc.dart';

sealed class DatabaseState {}

final class _Initial extends DatabaseState {}

final class DatabaseLoadingState extends DatabaseState {}

final class DatabaseLoadedState extends DatabaseState {
  DatabaseLoadedState(this.database);

  final Database database;
}

final class DatabaseCreatedState extends DatabaseState {
  DatabaseCreatedState(this.database);

  final Database database;
}

final class DatabaseUpdatedState extends DatabaseState {
  DatabaseUpdatedState(this.database);

  final Database database;
}
