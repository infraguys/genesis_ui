import 'package:json_annotation/json_annotation.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';

class NodeTypeConverter implements JsonConverter<NodeType, String> {
  const NodeTypeConverter();

  @override
  NodeType fromJson(String json) {
    return switch (json) {
      'HW' => .hw,
      'VM' => .vm,
      _ => .unknown,
    };
  }

  @override
  String toJson(NodeType object) {
    return switch (object) {
      .hw => 'HW',
      .vm => 'VM',
      _ => '',
    };
  }
}
