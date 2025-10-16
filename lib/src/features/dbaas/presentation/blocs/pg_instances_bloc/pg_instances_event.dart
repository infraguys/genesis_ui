part of 'pg_instances_bloc.dart';

sealed class PgInstancesEvent {
  const factory PgInstancesEvent.getInstances([GetPgInstancesParams params]) = _GetInstances;

  const factory PgInstancesEvent.deleteInstances(List<PgInstance> instances) = _DeleteInstances;
}

final class _GetInstances implements PgInstancesEvent {
  const _GetInstances([this.params = const GetPgInstancesParams()]);

  final GetPgInstancesParams params;
}

final class _DeleteInstances implements PgInstancesEvent {
  const _DeleteInstances(this.instances);

  final List<PgInstance> instances;
}
