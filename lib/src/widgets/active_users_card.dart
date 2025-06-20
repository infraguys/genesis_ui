import 'package:flutter/material.dart';

class ActiveUsersCard extends StatelessWidget {
  const ActiveUsersCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Active Users', style: textTheme.titleMedium),
                RichText(
                  text: TextSpan(
                    text: '45',
                    style: textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: ' / 80',
                        style: textTheme.titleSmall!.copyWith(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // const Spacer(),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Text(secondaryTitle, style: theme.textTheme.titleMedium),
            //     Text(
            //       secondaryValue,
            //       style: theme.textTheme.headlineMedium!.copyWith(
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
