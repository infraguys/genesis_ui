part of 'nodes_bloc.dart';

sealed class NodesEvent {
  factory NodesEvent.getNodes([GetNodesParams params]) = _GetNodes;

  factory NodesEvent.deleteNodes(List<Node> nodes) = _DeleteNodes;
}

final class _GetNodes implements NodesEvent {
  _GetNodes([this._params = const GetNodesParams()]);

  final GetNodesParams _params;
}

final class _DeleteNodes implements NodesEvent {
  _DeleteNodes(this.nodes);

  final List<Node> nodes;
}
