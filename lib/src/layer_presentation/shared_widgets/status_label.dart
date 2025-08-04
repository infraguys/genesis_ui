import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:genesis/src/theming/palette.dart';

class StatusLabel extends StatelessWidget {
  const StatusLabel({required Status status, super.key}) : _status = status;

  final Status _status;

  Color get textStatusColor => switch (_status) {
    Status.active => Palette.color6DCF91,
    Status.inactive => Palette.colorF04C4C,
    // TODO: Handle unknown status
    Status.unknown => throw UnimplementedError(),
  };

  Color get labelStatusColor => switch (_status) {
    Status.active => Palette.color6DCF91.withValues(alpha: 0.10),
    Status.inactive => Palette.colorF04C4C.withValues(alpha: 0.10),
    // TODO: Handle unknown status
    Status.unknown => throw UnimplementedError(),
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
