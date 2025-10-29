part of './node_bloc.dart';

sealed class NodeState {
  bool get shouldListen => this is! NodeLoadingState || this is! _InitialState;
}

final class _InitialState extends NodeState {}

final class NodeLoadingState extends NodeState {}

final class NodeLoadedState extends NodeState {
  NodeLoadedState(this.node);

  final Node node;
}

final class NodeUpdatedState extends NodeState {
  NodeUpdatedState(this.node);

  final Node node;
}

final class NodeCreatedState extends NodeState {
  NodeCreatedState(this.node);

  final Node node;
}

final class NodeDeletedState extends NodeState {
  NodeDeletedState(this.node);

  final Node node;
}

final class NodeFailureState extends NodeState {
  NodeFailureState(this.message);

  final String message;
}

final class NodePermissionFailureState extends NodeState {
  NodePermissionFailureState(this.message);

  final String message;
}
