import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';

class VerifiedUsersCountCard extends StatelessWidget {
  const VerifiedUsersCountCard({super.key});

  int getVerifiedUsersCount(List<User> users) => users.where((user) => user.emailVerified).length;

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
                Text('Verified Users', style: textTheme.titleMedium),
                BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    if (state is! UsersLoadedState) {
                      return Text(
                        'Loading...',
                        style: textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                      );
                    }
                    final users = state.users;
                    return RichText(
                      text: TextSpan(
                        text: getVerifiedUsersCount(users).toString(),
                        style: textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: ' / ${users.length}',
                            style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
