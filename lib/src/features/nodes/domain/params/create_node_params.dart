import 'package:genesis/src/features/nodes/domain/entities/node.dart';

final class CreateNodeParams {
  const CreateNodeParams({
    required this.name,
    required this.description,
    required this.cores,
    required this.ram,
    required this.rootDiskSize,
    required this.image,
    required this.nodeType,
  });

  final String name;
  final String description;
  final int cores;
  final int ram;
  final int rootDiskSize;
  final String image;
  final NodeType nodeType;
}
