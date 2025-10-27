part of 'databases_bloc.dart';

sealed class DatabasesState {}

final class _DatabasesInitialState extends DatabasesState {}

final class DatabasesLoadingState extends DatabasesState {}

final class DatabasesLoadedState extends DatabasesState {
  DatabasesLoadedState(this.databases);

  final List<Database> databases;
}

final class DatabasesCreatedState extends DatabasesState {
  DatabasesCreatedState(this.database);

  final Database database;
}
