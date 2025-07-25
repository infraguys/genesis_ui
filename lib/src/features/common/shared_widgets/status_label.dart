import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/theming/palette.dart';

class StatusLabel extends StatelessWidget {
  const StatusLabel({required UserStatus status, super.key}) : _status = status;

  final UserStatus _status;

  Color get textStatusColor => switch (_status) {
    UserStatus.active => Palette.color6DCF91,
    UserStatus.inactive => Palette.colorF04C4C,
  };

  Color get labelStatusColor => switch (_status) {
    UserStatus.active => Palette.color6DCF91.withValues(alpha: 0.10),
    UserStatus.inactive => Palette.colorF04C4C.withValues(alpha: 0.10),
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: labelStatusColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: Text(
            _status.humanReadable(context),
            style: textTheme.labelMedium! + textStatusColor,
          ),
        ),
      ),
    );
  }
}

// Palette.color6DCF91
