import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';

enum Status { active, inactive }

extension UserStatusExtension on Status {
  String humanReadable(BuildContext context) => switch (this) {
    Status.active => context.$.active,
    Status.inactive => context.$.inactive,
  };
}
