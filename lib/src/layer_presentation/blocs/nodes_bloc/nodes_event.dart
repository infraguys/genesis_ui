part of 'nodes_bloc.dart';

sealed class NodesEvent {
  factory NodesEvent.getNodes([GetNodesParams params]) = _GetNodes;
}

final class _GetNodes implements NodesEvent {
  _GetNodes([this._params = const GetNodesParams()]);

  final GetNodesParams _params;
}
