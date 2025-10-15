import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';

class VerifiedLabel extends StatelessWidget {
  const VerifiedLabel({super.key, bool isVerified = false}) : _isVerified = isVerified;

  final bool _isVerified;

  Color get _textStatusColor => switch (_isVerified) {
    true => Palette.color6DCF91,
    _ => Palette.colorF04C4C,
  };

  Color get _labelStatusColor => switch (_isVerified) {
    true => Palette.color6DCF91.withValues(alpha: 0.10),
    _ => Palette.colorF04C4C.withValues(alpha: 0.10),
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return SizedBox(
      width: 144,
      height: 24,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _labelStatusColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            _isVerified ? context.$.verified : context.$.unverified,
            style: textTheme.labelLarge! + _textStatusColor,
          ),
        ),
      ),
    );
  }
}
