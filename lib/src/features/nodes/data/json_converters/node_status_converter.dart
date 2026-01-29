import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:json_annotation/json_annotation.dart';

class NodeStatusConverter implements JsonConverter<NodeStatus, String> {
  const NodeStatusConverter();

  @override
  NodeStatus fromJson(String json) {
    return switch (json) {
      'NEW' => .newStatus,
      'ACTIVE' => .active,
      'IN_PROGRESS' => .inProgress,
      'ERROR' => .error,
      'SCHEDULED' => .scheduled,
      'STARTED' => .started,
      _ => .unknown,
    };
  }

  @override
  String toJson(NodeStatus status) {
    return switch (status) {
      .newStatus => 'NEW',
      .active => 'ACTIVE',
      .inProgress => 'IN_PROGRESS',
      .error => 'ERROR',
      .scheduled => 'SCHEDULED',
      .started => 'STARTED',
      _ => '',
    };
  }
}
