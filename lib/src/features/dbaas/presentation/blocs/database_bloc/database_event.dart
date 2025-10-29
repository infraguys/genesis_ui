part of 'database_bloc.dart';

sealed class DatabaseEvent {
  DatabaseEvent();

  factory DatabaseEvent.get(DatabaseParams params) = _GetDatabase;

  factory DatabaseEvent.create(CreateDatabaseParams params) = _CreateDatabase;

  factory DatabaseEvent.update(UpdateDatabaseParams params) = _UpdateDatabase;
}

final class _GetDatabase extends DatabaseEvent {
  _GetDatabase(this.params);

  final DatabaseParams params;
}

final class _CreateDatabase extends DatabaseEvent {
  _CreateDatabase(this.params);

  final CreateDatabaseParams params;
}

final class _UpdateDatabase extends DatabaseEvent {
  _UpdateDatabase(this.params);

  final UpdateDatabaseParams params;
}
