part of 'databases_bloc.dart';

sealed class DatabasesEvent {
  DatabasesEvent();

  factory DatabasesEvent.createDatabase(CreateDatabaseParams params) => _CreateDatabase(params);

  factory DatabasesEvent.getDatabases(GetDatabasesParams params) = _GetDatabases;

  factory DatabasesEvent.deleteDatabases(List<Database> databases) = _DeleteDatabases;
}

final class _CreateDatabase extends DatabasesEvent {
  _CreateDatabase(this.params);

  final CreateDatabaseParams params;
}

final class _GetDatabases extends DatabasesEvent {
  _GetDatabases(this.params);

  final GetDatabasesParams params;
}

final class _DeleteDatabases extends DatabasesEvent {
  _DeleteDatabases(this.databases);

  final List<Database> databases;
}
