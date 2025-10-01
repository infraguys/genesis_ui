part of 'node_bloc.dart';

sealed class NodeState {
  factory NodeState.initial() = NodeInitialState;

  factory NodeState.loading() = NodeLoadingState;

  factory NodeState.loaded(Node node) = NodeLoadedState;

  factory NodeState.updated(Node node) = NodeUpdatedState;

  factory NodeState.created(Node node) = NodeCreatedState;

  factory NodeState.deleted(Node node) = NodeDeletedState;

  factory NodeState.failure(String message) = NodeFailureState;

  factory NodeState.permissionFailure(String message) = NodePermissionFailureState;
}

final class NodeInitialState implements NodeState {}

final class NodeLoadingState implements NodeState {}

final class NodeLoadedState extends _NodeDataState {
  NodeLoadedState(super.node);
}

final class NodeFailureState extends _FailureState {
  NodeFailureState(super.message);
}

final class NodePermissionFailureState extends _FailureState {
  NodePermissionFailureState(super.message);
}

final class NodeUpdatedState extends _NodeDataState {
  NodeUpdatedState(super.node);
}

final class NodeCreatedState extends _NodeDataState {
  NodeCreatedState(super.node);
}

final class NodeDeletedState extends _NodeDataState {
  NodeDeletedState(super.node);
}

// Base classes to reduce code duplication

base class _NodeDataState implements NodeState {
  _NodeDataState(this.node);

  final Node node;
}

base class _FailureState implements NodeState {
  _FailureState(this.message);

  final String message;
}
