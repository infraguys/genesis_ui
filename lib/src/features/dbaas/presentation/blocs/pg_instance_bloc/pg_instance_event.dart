part of 'pg_instance_bloc.dart';

sealed class PgInstanceEvent {
  factory PgInstanceEvent.getInstance(PgInstanceID id) = _GetInstance;

  factory PgInstanceEvent.createInstance(CreatePgInstanceParams params) = _CreateInstance;
}

final class _GetInstance implements PgInstanceEvent {
  _GetInstance(this.id);

  final PgInstanceID id;
}

final class _CreateInstance implements PgInstanceEvent {
  _CreateInstance(this.params);

  final CreatePgInstanceParams params;
}

// final class _UpdateNode implements NodeEvent {
//   _UpdateNode(this.params);
//
//   final UpdateNodeParams params;
// }
//
// final class _DeleteNode implements NodeEvent {
//   _DeleteNode(this.node);
//
//   final Node node;
// }
