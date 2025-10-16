part of 'pg_instance_bloc.dart';

sealed class PgInstanceEvent {
  factory PgInstanceEvent.getInstance(PgInstanceID id) = _GetInstance;

  factory PgInstanceEvent.createInstance(CreatePgInstanceParams params) = _CreateInstance;

  factory PgInstanceEvent.updateInstance(UpdatePgInstanceParams params) = _UpdateInstance;

  factory PgInstanceEvent.delete(PgInstance instance) = _DeleteInstance;
}

final class _GetInstance implements PgInstanceEvent {
  _GetInstance(this.id);

  final PgInstanceID id;
}

final class _CreateInstance implements PgInstanceEvent {
  _CreateInstance(this.params);

  final CreatePgInstanceParams params;
}

final class _DeleteInstance implements PgInstanceEvent {
  _DeleteInstance(this.instance);

  final PgInstance instance;
}

final class _UpdateInstance implements PgInstanceEvent {
  _UpdateInstance(this.params);

  final UpdatePgInstanceParams params;
}
