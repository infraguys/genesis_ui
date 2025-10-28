part of 'databases_bloc.dart';

sealed class DatabasesEvent {
  DatabasesEvent();

  factory DatabasesEvent.getDatabases(GetDatabasesParams params) = _GetDatabases;

  factory DatabasesEvent.deleteDatabases(List<Database> databases) = _DeleteDatabases;
}

final class _GetDatabases extends DatabasesEvent {
  _GetDatabases(this.params);

  final GetDatabasesParams params;
}

final class _DeleteDatabases extends DatabasesEvent {
  _DeleteDatabases(this.databases);

  final List<Database> databases;
}
