import 'package:flutter/material.dart';
import 'package:genesis_admin_dashboard_template/features/iam/user_data.dart';
import 'package:genesis_admin_dashboard_template/features/iam/models.dart';
import 'package:genesis_admin_dashboard_template/router.dart';
import 'package:gap/gap.dart';

import '../../widgets/widgets.dart';

class VpnsPage extends StatelessWidget {
  const VpnsPage({super.key});

  static List<User> getUsers() => genesisUsers;

  String getCellTitle(User user, int index) {
    return '${user.firstName} ${user.lastName}';
  }

  String getCellSubtitle(User user, int index) {
    return '${user.email}\n10.10.0.${index + 10}';
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
            title: 'VPNs',
            description: 'A list of users who has VPN access.',
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
                      getCellTitle(user, index),
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      getCellSubtitle(user, index),
                      style: theme.textTheme.labelMedium,
                    ),
                    // isThreeLine: true,
                    leading: Icon(
                      Icons.person_outlined,
                      color: isOk(user) ? 
                        theme.colorScheme.primary : theme.colorScheme.error,
                    ),
                    trailing: Switch(
                      value: isOk(user),
                      onChanged: (value) {
                        // setState(() {
                        //   isSwitched = value;
                        // });
                      },
                      activeTrackColor: theme.colorScheme.primaryContainer,
                      activeColor: theme.colorScheme.primary,
                    ),
                    onTap: () {
                      // Do nothing so far
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
