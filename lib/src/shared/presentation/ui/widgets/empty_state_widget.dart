import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.button,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 150, color: Colors.white24),
          Text(title, style: theme.textTheme.titleMedium! + Colors.white24),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium! + Colors.white24,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          SizedBox(width: 200, child: button),
        ],
      ),
    );
  }
}
