part of 'pg_instances_bloc.dart';

sealed class PgInstancesEvent {
  const factory PgInstancesEvent.getInstances([GetPgInstancesParams params]) = _GetInstances;
}

final class _GetInstances implements PgInstancesEvent {
  const _GetInstances([this.params = const GetPgInstancesParams()]);

  final GetPgInstancesParams params;
}
