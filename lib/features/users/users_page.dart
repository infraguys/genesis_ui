import 'package:flutter/material.dart';
import 'package:genesis_admin_dashboard_template/features/iam/user_data.dart';
import 'package:genesis_admin_dashboard_template/features/iam/models.dart';
import 'package:genesis_admin_dashboard_template/router.dart';
import 'package:gap/gap.dart';

import '../../widgets/widgets.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  static List<User> getUsers() => genesisUsers;

  String getCellTitle(User user) {
    return '${user.firstName} ${user.lastName}';
  }

  String getCellSubtitle(User user) {
    return user.email;
  }

  bool isOk(User user) => user.status == 'ACTIVE';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ContentView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Users',
            description: 'A list of users who registered in the Genesis IAM.',
          ),
          const Gap(16),
          Expanded(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: ListView.separated(
                itemCount: getUsers().length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final user = getUsers()[index];
                  return ListTile(
                    title: Text(
                      getCellTitle(user),
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      getCellSubtitle(user),
                      style: theme.textTheme.labelMedium,
                    ),
                    // isThreeLine: true,
                    leading: Icon(
                      Icons.person_outlined,
                      color: isOk(user) ? 
                        theme.colorScheme.primary : theme.colorScheme.error,
                    ),
                    trailing: const Icon(Icons.navigate_next_outlined),
                    onTap: () {
                      UserPageRoute(userUuid: user.uuid).go(context);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
