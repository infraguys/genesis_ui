part of 'db_versions_bloc.dart';

sealed class DbVersionsEvent {
  const DbVersionsEvent();

  factory DbVersionsEvent.getDbVersions(GetDbVersionsParams params) = _GetDbVersions;
}

final class _GetDbVersions extends DbVersionsEvent {
  _GetDbVersions(this.params);

  final GetDbVersionsParams params;
}
