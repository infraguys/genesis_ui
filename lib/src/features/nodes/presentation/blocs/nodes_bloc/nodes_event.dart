part of 'nodes_bloc.dart';

sealed class NodesEvent {
  factory NodesEvent.getNodes([GetNodesParams params = const GetNodesParams()]) => _GetNodes(params);

  factory NodesEvent.deleteNodes(List<Node> nodes) = _DeleteNodes;

  factory NodesEvent.failure(String message) = _Failure;

  factory NodesEvent.startPollingInstances() = _StartPolling;

  factory NodesEvent.stopPollingInstances() = _StopPolling;
}

final class _GetNodes implements NodesEvent {
  _GetNodes(this.params);

  final GetNodesParams params;
}

final class _DeleteNodes implements NodesEvent {
  _DeleteNodes(this.nodes);

  final List<Node> nodes;
}

final class _Failure implements NodesEvent {
  _Failure(this.message);

  final String message;
}

final class _StartPolling implements NodesEvent {}

final class _StopPolling implements NodesEvent {}

final class _Tick implements NodesEvent {
  _Tick(this.params);

  final GetNodesParams params;
}
