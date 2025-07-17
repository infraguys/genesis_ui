import 'package:flutter/material.dart';

class CustomOptionsView extends StatelessWidget {
  const CustomOptionsView({
    required this.options,
    required this.onSelected,
    super.key,
  });

  final Iterable<String> options;
  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        color: Colors.grey[850],
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: options.length,
          separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey[700]),
          itemBuilder: (context, index) {
            final option = options.elementAt(index);
            return InkWell(
              onTap: () => onSelected(option),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(option, style: const TextStyle(color: Colors.white)),
              ),
            );
          },
        ),
      ),
    );
  }
}
