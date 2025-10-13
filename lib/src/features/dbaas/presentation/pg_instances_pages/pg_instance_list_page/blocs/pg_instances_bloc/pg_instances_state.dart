part of 'pg_instances_bloc.dart';

sealed class PgInstancesState {}

final class PgInstancesInitialState implements PgInstancesState {}

final class PgInstancesLoadingState implements PgInstancesState {}

final class PgInstancesLoadedState implements PgInstancesState {
  PgInstancesLoadedState(this.instances);
  final List<PgInstance> instances;
}
