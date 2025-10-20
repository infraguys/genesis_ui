part of 'pg_instances_bloc.dart';

sealed class PgInstancesState {}

final class PgInstancesInitialState implements PgInstancesState {}

final class PgInstancesLoadingState implements PgInstancesState {}

final class PgInstancesLoadedState implements PgInstancesState {
  PgInstancesLoadedState(this.instances);

  int get activeCount => instances.where((it) => it.status == PgInstanceStatus.active).toList().length;

  int get newCount => instances.where((it) => it.status == PgInstanceStatus.newStatus).toList().length;

  int get inProgressCount => instances.where((it) => it.status == PgInstanceStatus.inProgress).toList().length;

  final List<PgInstance> instances;
}

final class PgInstancesDeletedState implements PgInstancesState {
  PgInstancesDeletedState(this.instances);

  final List<PgInstance> instances;
}

extension PgInstancesStateX on PgInstancesState {
  bool get shouldBuild => this is PgInstancesLoadingState || this is PgInstancesLoadedState;
}
