part of 'nodes_bloc.dart';

sealed class NodesState {
  factory NodesState.initial() = NodesInitialState;

  factory NodesState.loading() = NodesLoadingState;

  factory NodesState.loaded(List<Node> nodes) = NodesLoadedState;

  factory NodesState.deleted() = NodesDeletedState;
}

final class NodesInitialState implements NodesState {}

final class NodesLoadingState implements NodesState {}

final class NodesDeletedState implements NodesState {}

final class NodesLoadedState implements NodesState {
  NodesLoadedState(this.nodes);

  final List<Node> nodes;
}
