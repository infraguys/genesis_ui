import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(description),
        const SizedBox(height: 20,),
        Divider(
          color: Colors.grey.shade300,
          thickness: 1,
          height: 1,
          indent: 20,
          endIndent: 20,
        )
      ],
    );
  }
}
