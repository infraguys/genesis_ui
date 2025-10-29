part of 'nodes_bloc.dart';

sealed class NodesState {}

final class NodesInitialState implements NodesState {}

final class NodesLoadingState implements NodesState {}

final class NodesDeletedState implements NodesState {}

final class NodesLoadedState implements NodesState {
  NodesLoadedState(this.nodes);

  final List<Node> nodes;
}

final class NodesFailureState implements NodesState {
  NodesFailureState(this.message);

  final String message;
}
