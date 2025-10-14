import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/base_status.dart';

class PgInstance extends Equatable {
  const PgInstance({
    required this.id,
    required this.name,
    required this.description,
    required this.projectId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    // required this.ipv4,
    required this.cores,
    required this.ram,
    required this.diskSize,
    required this.nodesNumber,
    required this.syncReplicaNumber,
    required this.version,
  });

  final PgInstanceID id;
  final String name;
  final String? description;
  final String projectId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PgInstanceStatus status;
  // final List<String> ipv4;
  final int cores;
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
    createdAt,
    updatedAt,
    status,
    // ipv4,
    cores,
    ram,
    diskSize,
    nodesNumber,
    syncReplicaNumber,
    version,
  ];
}

extension type PgInstanceID(String raw) {}

/// ACTIVE, ERROR, IN_PROGRESS, NEW
enum PgInstanceStatus implements BaseStatusEnum {
  newStatus,
  active,
  error,
  inProgress,
  unknown;

  @override
  String humanReadable(BuildContext context) => switch (this) {
    newStatus => context.$.newStatus,
    active => context.$.active,
    error => context.$.error,
    inProgress => context.$.inProgress,
    _ => 'Unknown'.hardcoded,
  };
}
