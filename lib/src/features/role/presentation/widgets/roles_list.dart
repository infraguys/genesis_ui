import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/role/presentation/blocs/user_roles_bloc/user_roles_bloc.dart';

class RolesList extends StatefulWidget {
  const RolesList({super.key});

  @override
  State<RolesList> createState() => _RolesListState();
}

class _RolesListState extends State<RolesList> {
  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return BlocBuilder<UserRolesBloc, UserRolesState>(
      builder: (context, state) {
        if (state is! UserRolesLoaded) {
          return SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Роли', style: textTheme.headlineSmall),
            SizedBox(height: 24),
            Wrap(
              spacing: 12,
              children: state.roles.map(
                (it) {
                  return Chip(label: Text(it.name));
                },
              ).toList(),
            ),
          ],
        );
      },
    );
  }
}
