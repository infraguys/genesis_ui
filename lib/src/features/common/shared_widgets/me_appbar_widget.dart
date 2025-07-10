import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class MeAppbarWidget extends StatelessWidget {
  const MeAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is! Authenticated) {
          return SizedBox.shrink();
        }
        final user = authState.iamClient.user;
        final firstLetter = user.firstName.substring(0, 1).toUpperCase();
        final secondLetter = user.lastName.substring(0, 1).toUpperCase();
        return Row(
          spacing: 10,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 12,
              child: Text(
                '$firstLetter$secondLetter',
                style: TextStyle(fontSize: 12),
              ),
            ),
            Text('${user.firstName} ${user.lastName}'),
          ],
        );
      },
    );
  }
}
