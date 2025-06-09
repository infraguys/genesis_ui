import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recase/recase.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(description),
      ],
    );
  }
}


class PageHeaderWithActions extends StatelessWidget {
  const PageHeaderWithActions({
    super.key,
    required this.title,
    required this.description,
    this.navigationBefore = true,
    this.actions = const ['actions', 'resize', 'share', 'delete'],
  });

  final String title;
  final String description;
  final navigationBefore;
  final List<String> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
              icon: const Icon(Icons.navigate_before),
              iconSize: theme.textTheme.headlineMedium?.fontSize ?? 16,
              onPressed: () {
                context.pop();
              },
            ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(description),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8),
          child: 
          // DropdownButton(items: [
          //     DropdownMenuItem(value: 'actions', child: Text('Actions'),),
          //     DropdownMenuItem(value: 'resize', child: Text('Resize'),),
          //     DropdownMenuItem(value: 'share', child: Text('Share'),),
          //     DropdownMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: theme.colorScheme.error),),),
          //   ],
          //   onChanged: (value) => print(value),
          //   value: "actions",
          // ),
          DropdownMenu<String>(
            initialSelection: "actions",
            onSelected: (String? value) {
              print(value);
            },
            dropdownMenuEntries: actions.map(
              (e) => DropdownMenuEntry(value: e, label: e.toUpperCase()),
            ).toList(),
          ),
        ),
      ],
    );
  }
}
