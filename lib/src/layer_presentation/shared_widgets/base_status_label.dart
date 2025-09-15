import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/core/interfaces/base_status.dart';

class BaseStatusLabel extends StatelessWidget {
  const BaseStatusLabel({
    required BaseStatusEnum status,
    required Color textStatusColor,
    required Color labelStatusColor,
    super.key,
  }) : _status = status,
       _textStatusColor = textStatusColor,
       _labelStatusColor = labelStatusColor;

  final BaseStatusEnum _status;
  final Color _textStatusColor;
  final Color _labelStatusColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return SizedBox(
      width: 120,
      height: 24,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _labelStatusColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            _status.humanReadable(context),
            style: textTheme.labelLarge! + _textStatusColor,
          ),
        ),
      ),
    );
  }
}
