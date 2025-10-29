part of 'clusters_bloc.dart';

sealed class ClustersEvent {
  const factory ClustersEvent.getClusters([GetClustersParams params]) = _GetClusters;

  const factory ClustersEvent.deleteClusters(List<Cluster> instances) = _DeleteClusters;

  factory ClustersEvent.startPolling() = _StartPolling;

  factory ClustersEvent.stopPolling() = _StopPolling;
}

final class _GetClusters implements ClustersEvent {
  const _GetClusters([this.params = const GetClustersParams()]);

  final GetClustersParams params;
}

final class _DeleteClusters implements ClustersEvent {
  const _DeleteClusters(this.clusters);

  final List<Cluster> clusters;
}

final class _StartPolling implements ClustersEvent {}

final class _Tick implements ClustersEvent {
  const _Tick(this.params);

  final GetClustersParams params;
}

final class _StopPolling implements ClustersEvent {}
