import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Петя - $userId'),
        // Text('${user.firstName} ${user.lastName}')
      ],
    );
  }
}
