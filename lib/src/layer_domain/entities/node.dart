import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/base_status.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';

class Node extends Equatable {
  const Node({
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.projectId,
    required this.name,
    required this.description,
    required this.cores,
    required this.ram,
    required this.rootDiskSize,
    required this.image,
    required this.status,
    required this.nodeType,
    required this.ipv4,
  });

  final NodeUUID uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProjectUUID projectId;
  final String name;
  final String description;
  final int cores;
  final int ram;
  final int rootDiskSize;
  final String image;
  final NodeStatus status;
  final NodeType nodeType;
  final String ipv4;

  @override
  List<Object?> get props => [
    uuid,
    createdAt,
    updatedAt,
    projectId,
    name,
    description,
    cores,
    ram,
    rootDiskSize,
    image,
    status,
    nodeType,
    ipv4,
  ];
}

extension type NodeUUID(String value) {
  bool isEqualTo(NodeUUID other) => value == other.value;
}

enum NodeType {
  hw,
  vm,
}

/// ACTIVE, ERROR, IN_PROGRESS, NEW, SCHEDULED, STARTED
enum NodeStatus implements BaseStatusEnum {
  newStatus,
  active,
  error,
  inProgress,
  scheduled,
  started,
  unknown;

  @override
  String humanReadable(BuildContext context) => switch (this) {
    newStatus => context.$.newStatus,
    active => context.$.active,
    error => context.$.error,
    inProgress => 'In Progress'.hardcoded,
    scheduled => 'Scheduled'.hardcoded,
    started => 'Started'.hardcoded,
    _ => 'Unknown'.hardcoded,
  };
}
