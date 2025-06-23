import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('SignUp'),
            TextButton(
              onPressed: context.pop,
              child: const Text(
                'Go Back',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
