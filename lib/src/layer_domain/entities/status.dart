import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/base_status.dart';

enum Status implements BaseStatusEnum {
  active,
  inactive,
  unknown;

  @override
  String humanReadable(BuildContext context) => switch (this) {
    Status.active => context.$.active,
    Status.inactive => context.$.inactive,
    Status.unknown => 'Неизвестен'.hardcoded,
  };
}
