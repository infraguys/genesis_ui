part of 'node_bloc.dart';

sealed class NodeEvent {
  factory NodeEvent.getNode(NodeUUID uuid) = _GetNode;

  factory NodeEvent.create(CreateNodeParams params) = _CreateNode;

  factory NodeEvent.delete(Node node) = _DeleteNode;

  factory NodeEvent.update(UpdateNodeParams params) = _UpdateNode;
}

final class _GetNode implements NodeEvent {
  _GetNode(this.uuid);

  final NodeUUID uuid;
}

final class _CreateNode implements NodeEvent {
  _CreateNode(this.params);

  final CreateNodeParams params;
}

final class _UpdateNode implements NodeEvent {
  _UpdateNode(this.params);

  final UpdateNodeParams params;
}

final class _DeleteNode implements NodeEvent {
  _DeleteNode(this.node);

  final Node node;
}
