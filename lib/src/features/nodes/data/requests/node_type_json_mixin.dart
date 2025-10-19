import 'package:genesis/src/features/nodes/domain/entities/node.dart';

mixin NodeTypeJsonMixin {
  String? fromNodeTypeToJson(NodeType? type) => switch (type) {
    NodeType.hw => 'HW',
    NodeType.vm => 'VM',
    _ => null,
  };
}
