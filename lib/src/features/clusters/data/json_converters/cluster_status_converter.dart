import 'package:genesis/src/features/clusters/domain/entities/cluster.dart';
import 'package:json_annotation/json_annotation.dart';

class ClusterStatusConverter implements JsonConverter<ClusterStatus, String> {
  const ClusterStatusConverter();

  @override
  ClusterStatus fromJson(String json) {
    return switch (json) {
      'NEW' => .newStatus,
      'ACTIVE' => .active,
      'IN_PROGRESS' => .inProgress,
      'ERROR' => .error,
      _ => .unknown,
    };
  }

  @override
  String toJson(ClusterStatus status) {
    return switch (status) {
      .newStatus => 'NEW',
      .active => 'ACTIVE',
      .inProgress => 'IN_PROGRESS',
      .error => 'ERROR',
      _ => '',
    };
  }
}
