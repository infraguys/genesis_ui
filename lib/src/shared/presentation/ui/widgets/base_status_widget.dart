import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';

class BaseStatusWidget extends StatelessWidget {
  const BaseStatusWidget({
    required String text,
    required Color color,
    required Color labelColor,
    Size size = const Size(120, 24),
    super.key,
  }) : _text = text,
       _color = color,
       _labelColor = labelColor,
       _size = size;

  final String _text;
  final Color _color;
  final Color _labelColor;
  final Size _size;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return SizedBox.fromSize(
      size: _size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _labelColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(_text, style: textTheme.labelLarge! + _color),
        ),
      ),
    );
  }
}
