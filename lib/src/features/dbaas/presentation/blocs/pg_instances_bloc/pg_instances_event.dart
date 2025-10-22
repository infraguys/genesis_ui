part of 'pg_instances_bloc.dart';

sealed class PgInstancesEvent {
  const factory PgInstancesEvent.getInstances([GetPgInstancesParams params]) = _GetInstances;

  const factory PgInstancesEvent.deleteInstances(List<PgInstance> instances) = _DeleteInstances;

  factory PgInstancesEvent.startPollingInstances() = _StartPolling;

  factory PgInstancesEvent.stopPollingInstances() = _StopPolling;
}

final class _GetInstances implements PgInstancesEvent {
  const _GetInstances([this.params = const GetPgInstancesParams()]);

  final GetPgInstancesParams params;
}

final class _DeleteInstances implements PgInstancesEvent {
  const _DeleteInstances(this.instances);

  final List<PgInstance> instances;
}

final class _StartPolling implements PgInstancesEvent {}

final class _Tick implements PgInstancesEvent {
  const _Tick(this.params);

  final GetPgInstancesParams params;
}

final class _StopPolling implements PgInstancesEvent {}
