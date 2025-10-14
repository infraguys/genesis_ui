part of 'pg_instance_bloc.dart';

sealed class PgInstanceState {}

final class PgInstanceInitialState extends PgInstanceState {}

final class PgInstanceLoadingState extends PgInstanceState {}

final class PgInstanceFailureState extends _FailureState {
  PgInstanceFailureState(super.message);
}

final class PgInstanceLoadedState extends _DataState {
  PgInstanceLoadedState(super.instance);
}

final class PgInstanceUpdatedState extends _DataState {
  PgInstanceUpdatedState(super.instance);
}

final class PgInstanceCreatedState extends _DataState {
  PgInstanceCreatedState(super.instance);
}

final class PgInstanceDeletedState extends _DataState {
  PgInstanceDeletedState(super.instance);
}

// Base classes to reduce code duplication

base class _DataState implements PgInstanceState {
  _DataState(this.instance);

  final PgInstance instance;
}

base class _FailureState implements PgInstanceState {
  _FailureState(this.message);

  final String message;
}
