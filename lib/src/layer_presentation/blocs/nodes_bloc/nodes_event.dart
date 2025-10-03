part of 'nodes_bloc.dart';

sealed class NodesEvent {
  factory NodesEvent.getNodes([GetNodesParams params]) = _GetNodes;
  factory NodesEvent.deleteNodes(List<Node> nodes) = _DeleteNodes;
  factory NodesEvent.failure(String message) = _Failure;
}

final class _GetNodes implements NodesEvent {
  _GetNodes([this._params = const GetNodesParams()]);

  final GetNodesParams _params;
}

final class _DeleteNodes implements NodesEvent {
  _DeleteNodes(this.nodes);

  final List<Node> nodes;
}

final class _Failure implements NodesEvent {
  _Failure(this.message);

  final String message;
}
