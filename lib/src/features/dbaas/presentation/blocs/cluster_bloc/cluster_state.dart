part of 'cluster_bloc.dart';

sealed class ClusterState {
  bool get shouldListen => this is! _InitialState && this is! ClusterLoadingState;
}

final class _InitialState extends ClusterState {}

final class ClusterLoadingState extends ClusterState {}

final class ClusterFailureState extends _FailureState {
  ClusterFailureState(super.message);
}

final class ClusterLoadedState extends _DataState {
  ClusterLoadedState(super.cluster);
}

final class ClusterUpdatedState extends _DataState {
  ClusterUpdatedState(super.cluster);
}

final class ClusterCreatedState extends _DataState {
  ClusterCreatedState(super.cluster);
}

final class ClusterDeletedState extends _DataState {
  ClusterDeletedState(super.cluster);
}

// Base classes to reduce code duplication

base class _DataState extends ClusterState {
  _DataState(this.cluster);

  final Cluster cluster;
}

base class _FailureState extends ClusterState {
  _FailureState(this.message);

  final String message;
}
