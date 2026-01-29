import 'package:genesis/src/features/extensions/domain/entities/extension.dart';
import 'package:json_annotation/json_annotation.dart';

class ExtensionStatusConverter implements JsonConverter<ExtensionStatus, String?> {
  const ExtensionStatusConverter();

  @override
  ExtensionStatus fromJson(String? json) {
    return switch (json) {
      'NEW' => .newStatus,
      'ACTIVE' => .active,
      'IN_PROGRESS' => .inProgress,
      _ => .unknown,
    };
  }

  @override
  String? toJson(ExtensionStatus? status) {
    return switch (status) {
      .newStatus => 'NEW',
      .active => 'ACTIVE',
      .inProgress => 'IN_PROGRESS',
      _ => null,
    };
  }
}
