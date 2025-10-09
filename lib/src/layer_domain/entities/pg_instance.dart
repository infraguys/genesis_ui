import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/interfaces/base_status.dart';

class PGInstance extends Equatable{
  const PGInstance({
    required this.uuid,
    required this.name,
    required this.description,
    required this.projectId,
    required this.status,
    required this.ipsv4,
    required this.cpu,
    required this.ram,
    required this.diskSize,
    required this.nodesNumber,
    required this.syncReplicaNumber,
    required this.version,
  });

  final PGInstanceUUID uuid;
  final String name;
  final String? description;
  final String projectId;
  final String status;
  final List<String> ipsv4;
  final int cpu;
  final int ram;
  final int diskSize;
  final int nodesNumber;
  final int syncReplicaNumber;
  final String version;

  @override
  List<Object?> get props => [
    name,
    description,
    projectId,
    status,
    ipsv4,
    cpu,
    ram,
    diskSize,
    nodesNumber,
    syncReplicaNumber,
    version,
  ];
}

extension type PGInstanceUUID(String raw) {
  bool isEqualTo(PGInstanceUUID other) => raw == other.raw;
}

/// ACTIVE, ERROR, IN_PROGRESS, NEW
enum PGInstanceStatus implements BaseStatusEnum {
  newStatus,
  active,
  error,
  inProgress;

  @override
  String humanReadable(BuildContext context) => switch (this) {
    newStatus => context.$.newText,
    active => context.$.active,
    error => context.$.error,
    inProgress => context.$.inProgress,
  };
}