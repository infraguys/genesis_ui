part of 'db_versions_bloc.dart';

sealed class DbVersionsState {}

final class _InitialState extends DbVersionsState {}

final class DbVersionsLoadingState extends DbVersionsState {}

final class DbVersionsLoadedState extends DbVersionsState {
  DbVersionsLoadedState(this.versions);

  final List<DbVersion> versions;
}
