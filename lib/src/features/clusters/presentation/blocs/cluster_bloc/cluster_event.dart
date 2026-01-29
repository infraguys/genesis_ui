part of 'cluster_bloc.dart';

sealed class ClusterEvent {
  factory ClusterEvent.get(ClusterID id) = _Get;

  factory ClusterEvent.create(CreateClusterParams params) = _Create;

  factory ClusterEvent.update(UpdateClusterParams params) = _Update;

  factory ClusterEvent.delete(Cluster instance) = _Delete;

  factory ClusterEvent.startPolling(ClusterID id) = _StartPolling;

  factory ClusterEvent.stopPolling() = _StopPolling;
}

final class _Get implements ClusterEvent {
  _Get(this.id);

  final ClusterID id;
}

final class _Create implements ClusterEvent {
  _Create(this.params);

  final CreateClusterParams params;
}

final class _Delete implements ClusterEvent {
  _Delete(this.cluster);

  final Cluster cluster;
}

final class _Update implements ClusterEvent {
  _Update(this.params);

  final UpdateClusterParams params;
}

final class _StartPolling implements ClusterEvent {
  _StartPolling(this.id);

  final ClusterID id;
}

final class _StopPolling implements ClusterEvent {}

final class _Tick implements ClusterEvent {
  _Tick(this.id);

  final ClusterID id;
}
