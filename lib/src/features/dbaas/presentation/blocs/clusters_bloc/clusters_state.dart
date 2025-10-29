part of 'clusters_bloc.dart';

sealed class ClustersState {
  bool get shouldListen => this is! ClustersLoadingState && this is! _InitialState;
}

final class _InitialState extends ClustersState {}

final class ClustersLoadingState extends ClustersState {}

final class ClustersLoadedState extends ClustersState {
  ClustersLoadedState(this.clusters);

  int get activeCount => clusters.where((it) => it.status == ClusterStatus.active).toList().length;

  int get newCount => clusters.where((it) => it.status == ClusterStatus.newStatus).toList().length;

  int get inProgressCount => clusters.where((it) => it.status == ClusterStatus.inProgress).toList().length;

  final List<Cluster> clusters;
}

final class ClustersDeletedState extends ClustersState {
  ClustersDeletedState(this.clusters);

  final List<Cluster> clusters;
}


