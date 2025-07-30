import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';

enum Status { active, inactive, unknown }

extension UserStatusExtension on Status {
  String humanReadable(BuildContext context) => switch (this) {
    Status.active => context.$.active,
    Status.inactive => context.$.inactive,
    Status.unknown => 'Неизвестен'.hardcoded,
  };
}
