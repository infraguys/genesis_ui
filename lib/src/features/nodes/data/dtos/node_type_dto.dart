import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node_type_dto.g.dart';

@JsonEnum(alwaysCreate: true)
enum NodeTypeDto {
  @JsonValue('HW')
  hw,
  @JsonValue('VM')
  vm;

  String toJson() => _$NodeTypeDtoEnumMap[this]!;

  static NodeTypeDto of(NodeType type) => switch (type) {
    NodeType.vm => NodeTypeDto.vm,
    NodeType.hw => NodeTypeDto.hw,
  };

  NodeType toDomain() => switch (this) {
    hw => NodeType.hw,
    vm => NodeType.vm,
  };
}
