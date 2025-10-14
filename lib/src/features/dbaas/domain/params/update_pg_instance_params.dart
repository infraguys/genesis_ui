import 'package:genesis/src/layer_domain/entities/pg_instance.dart';

final class UpdatePgInstanceParams {
  UpdatePgInstanceParams({
    required this.id,
    required this.name,
    required this.cores,
    required this.ram,
    required this.diskSize,
    required this.nodesNumber,
    required this.syncReplicaNumber,
    required this.ipsv4,
    this.description,
  });

  final PgInstanceID id;
  final String? name;
  final String? description;
  final List<String>? ipsv4;
  final int? cores;
  final int? ram;
  final int? diskSize;
  final int? nodesNumber;
  final int? syncReplicaNumber;
}
