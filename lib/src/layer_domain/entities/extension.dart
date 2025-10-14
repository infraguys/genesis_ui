import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/interfaces/base_status.dart';

final class Extension extends Equatable {
  const Extension({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.version,
    required this.installType,
    required this.link,
  });

  final ExtensionID id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ExtensionStatus status;
  final String version;
  final String installType;
  final String link;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    createdAt,
    updatedAt,
    status,
    version,
    installType,
    link,
  ];
}

extension type ExtensionID(String value) {
  bool isEqualTo(ExtensionID other) => value == other.value;
}

enum ExtensionStatus implements BaseStatusEnum {
  newStatus,
  active,
  inProgress,
  unknown;

  @override
  String humanReadable(BuildContext context) => switch (this) {
    newStatus => context.$.newStatus,
    active => context.$.active,
    inProgress => context.$.inProgress,
    _ => context.$.unknown,
  };
}
