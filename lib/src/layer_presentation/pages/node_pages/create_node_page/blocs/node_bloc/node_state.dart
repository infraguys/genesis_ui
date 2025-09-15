part of 'node_bloc.dart';

sealed class NodeState {
  factory NodeState.initial() = NodeInitialState;

  factory NodeState.loading() = NodeLoadingState;

  factory NodeState.loaded(Node node) = NodeLoadedState;

  factory NodeState.updated(Node node) = NodeUpdatedState;

  factory NodeState.created(Node node) = NodeCreatedState;

  factory NodeState.deleted(Node node) = NodeDeletedState;

  factory NodeState.failure(String message) = NodeFailureState;
}

final class NodeInitialState implements NodeState {}

final class NodeLoadingState implements NodeState {}

final class NodeLoadedState implements NodeState {
  NodeLoadedState(this.node);

  final Node node;
}

final class NodeFailureState implements NodeState {
  NodeFailureState(this.message);

  final String message;
}

final class NodeUpdatedState implements NodeState {
  NodeUpdatedState(this.node);

  final Node node;
}

final class NodeCreatedState implements NodeState {
  NodeCreatedState(this.node);

  final Node node;
}

final class NodeDeletedState implements NodeState {
  NodeDeletedState(this.node);

  final Node node;
}
