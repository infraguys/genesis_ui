import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';

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
                BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    if (state is! UsersLoadedState) {
                      return Text(
                        'Loading...',
                        style: textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                      );
                    }
                    return RichText(
                      text: TextSpan(
                        text: state.users.where((it) => it.status == UserStatus.active).length.toString(),
                        style: textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: ' / ${state.users.length}',
                            style: textTheme.titleSmall!.copyWith(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
