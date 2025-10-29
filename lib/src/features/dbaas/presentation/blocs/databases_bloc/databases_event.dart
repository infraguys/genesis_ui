part of 'databases_bloc.dart';

sealed class DatabasesEvent {
  DatabasesEvent();

  factory DatabasesEvent.getDatabases(GetDatabasesParams params) = _GetDatabases;

  factory DatabasesEvent.deleteDatabases({
    required List<Database> databases,
    required ClusterID clusterId,
  }) = _DeleteDatabases;
}

final class _GetDatabases extends DatabasesEvent {
  _GetDatabases(this.params);

  final GetDatabasesParams params;
}

final class _DeleteDatabases extends DatabasesEvent {
  _DeleteDatabases({required this.databases, required this.clusterId});

  final List<Database> databases;
  final ClusterID clusterId;
}
