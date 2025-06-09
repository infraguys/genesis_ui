import 'package:flutter/material.dart';
import 'package:genesis_admin_dashboard_template/features/nodes/data.dart';
import 'package:genesis_admin_dashboard_template/features/nodes/models.dart';
import 'package:genesis_admin_dashboard_template/router.dart';
import 'package:gap/gap.dart';

import '../../widgets/widgets.dart';

class NodesPage extends StatelessWidget {
  const NodesPage({super.key});

  static List<Node> getNodes() => genesisCoreNodes;

  String getCellTitle(Node node) {
    final ip = node.default_network['ipv4'] as String;

    if (node.name.isEmpty) {
      return ip;
    }

    return node.name;
  }

  String getCellSubtitle(Node node) {
    final ip = node.default_network['ipv4'] as String;
    return ip;
  }

  bool isOk(Node node) => node.status == 'ACTIVE';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ContentView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Nodes',
            description: 'List of nodes in the current installation.',
          ),
          const Gap(16),
          Expanded(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: ListView.separated(
                itemCount: getNodes().length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final node = getNodes()[index];
                  return ListTile(
                    title: Text(
                      getCellTitle(node),
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      getCellSubtitle(node),
                      style: theme.textTheme.labelMedium,
                    ),
                    // isThreeLine: true,
                    leading: Icon(
                      Icons.computer_outlined,
                      color: isOk(node) ? 
                        theme.colorScheme.primary : theme.colorScheme.error,
                    ),
                    trailing: const Icon(Icons.navigate_next_outlined),
                    onTap: () {
                      NodePageRoute(nodeUuid: node.uuid).go(context);
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
