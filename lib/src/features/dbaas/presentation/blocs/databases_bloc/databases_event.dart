part of 'databases_bloc.dart';

sealed class DatabasesEvent {
  const DatabasesEvent();

  factory DatabasesEvent.getDatabases(GetDatabasesParams params) = _GetDatabases;

  factory DatabasesEvent.deleteDatabases({
    required List<Database> databases,
    required ClusterID clusterId,
  }) = _DeleteDatabases;

  factory DatabasesEvent.startPolling(ClusterID clusterId) = _StartPolling;

  factory DatabasesEvent.stopPolling() = _StopPolling;
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

final class _StartPolling extends DatabasesEvent {
  _StartPolling(this.clusterId);

  final ClusterID clusterId;
}

final class _StopPolling extends DatabasesEvent {}

final class _Tick extends DatabasesEvent {
  const _Tick(this.params);

  final GetDatabasesParams params;
}
