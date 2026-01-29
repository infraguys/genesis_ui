import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:json_annotation/json_annotation.dart';

class NodeIdConverter extends JsonConverter<NodeID, String> {
  const NodeIdConverter();

  @override
  NodeID fromJson(String json) => NodeID(json);

  @override
  String toJson(NodeID object) => object.raw;
}