import 'package:genesis/src/layer_domain/entities/node.dart';

final class UpdateNodeParams {
  const UpdateNodeParams({
    required this.id,
    required this.name,
    required this.description,
    required this.cores,
    required this.ram,
    required this.rootDiskSize,
    required this.image,
    required this.nodeType,
  });

  final NodeID id;
  final String name;
  final String description;
  final int cores;
  final int ram;
  final int rootDiskSize;
  final String image;
  final NodeType nodeType;
}
