part of 'node_bloc.dart';

sealed class NodeEvent {
  factory NodeEvent.getNode(NodeUUID uuid) = _GetNode;

  factory NodeEvent.create(CreateNodeParams params) = _CreateNode;
}

final class _GetNode implements NodeEvent {
  _GetNode(this.uuid);

  final NodeUUID uuid;
}

final class _CreateNode implements NodeEvent {
  _CreateNode(this.params);

  final CreateNodeParams params;
}
