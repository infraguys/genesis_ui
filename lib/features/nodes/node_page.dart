import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';
import 'package:genesis_admin_dashboard_template/features/nodes/data.dart';
import 'package:genesis_admin_dashboard_template/features/nodes/models.dart';
import 'package:genesis_admin_dashboard_template/widgets/info_card.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';


import '../../widgets/widgets.dart';

// class NodePage extends StatelessWidget {
//   const NodePage({super.key, required this.node});

//   final Node node;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return ContentView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             node.name,
//             style: theme.textTheme.headlineMedium!.copyWith(
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           Text('IP: ${node.name}'),
//           Text('nodeUuid: ${node.uuid}'),
//           const Gap(16),
//           ElevatedButton.icon(
//             icon: const Icon(Icons.navigate_before),
//             label: const Text('Back'),
//             onPressed: () {
//               context.pop();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

class NodePage extends StatelessWidget {
  const NodePage({super.key, required this.node, this.infoCardWidth = 3});

  final Node node;
  final int infoCardWidth;

  int totalNodes() {
    return genesisCoreNodes.length;
  }

  String _getTitle() => 'Node';

  List<InfoCardCellContent> _buildNodeGeneralCardItems(ThemeData theme) {
    return [
      InfoCardCellContent(
        name: 'Cores',
        value: node.cores.toString(),
      ),
      InfoCardCellContent(
        name: 'Memory (Mb)',
        value: node.ram.toString(),
      ),
      InfoCardCellContent(
        name: 'Disk (Gb)',
        value: node.root_disk_size.toString(),
      ),
      InfoCardCellContent(
        name: 'Project',
        value: node.project_id,
      ),
      InfoCardCellContent(
        name: 'Created',
        value: DateTime.parse(node.created_at).toLocal().toString(),
      ),
      InfoCardCellContent(
        name: 'Status',
        value: node.status,
        valueFilling: true,
        valueColor: node.status == 'ACTIVE' ? 
          theme.colorScheme.primary : theme.colorScheme.error,
      ),
    ];
  }

  List<InfoCardCellContent> _buildNodeNetworkCardItems() {
    return [
      InfoCardCellContent(
        name: 'IP',
        value: node.default_network['ipv4'] as String,
      ),
      InfoCardCellContent(
        name: 'Mask',
        value: node.default_network['mask'] as String,
      ),
      InfoCardCellContent(
        name: 'Mac',
        value: node.default_network['mac'] as String,
      ),
      InfoCardCellContent(
        name: 'Subnet',
        value: node.default_network['subnet'] as String,
      ),
      InfoCardCellContent(
        name: 'Port',
        value: node.default_network['port'] as String,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final responsive = ResponsiveBreakpoints.of(context);

    return ContentView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeaderWithActions(
            title: node.name,
            description: node.uuid,
          ),
          const Gap(16),
          InfoCard(
            title: 'General Information', width: infoCardWidth,
            items: _buildNodeGeneralCardItems(theme),
          ),
          const Gap(16),
          InfoCard(
            title: 'Network', width: infoCardWidth,
            items: _buildNodeNetworkCardItems(),
          ),
        ],
      ),
    );
  }
}