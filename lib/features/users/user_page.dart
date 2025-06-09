import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';
import 'package:genesis_admin_dashboard_template/features/iam/models.dart';
import 'package:genesis_admin_dashboard_template/features/iam/user_data.dart';
import 'package:genesis_admin_dashboard_template/widgets/info_card.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';


import '../../widgets/widgets.dart';


class UserPage extends StatelessWidget {
  const UserPage({super.key, required this.user, this.infoCardWidth = 3});

  final User user;
  final int infoCardWidth;

  List<InfoCardCellContent> _buildUserGeneralCardItems(ThemeData theme) {
    return [
      InfoCardCellContent(
        name: 'First name',
        value: user.firstName,
      ),
      InfoCardCellContent(
        name: 'Last name',
        value: user.lastName,
      ),
      InfoCardCellContent(
        name: 'username',
        value: user.username,
      ),
      InfoCardCellContent(
        name: 'email',
        value: user.email,
      ),
      InfoCardCellContent(
        name: 'Created',
        value: DateTime.parse(user.createdAt).toLocal().toString(),
      ),
      InfoCardCellContent(
        name: 'Status',
        value: user.status,
        valueFilling: true,
        valueColor: user.status == 'ACTIVE' ? 
          theme.colorScheme.primary : theme.colorScheme.error,
      ),
    ];
  }

  List<InfoCardCellContent> _buildUserExtraCardItems() {
    return [
      InfoCardCellContent(
        name: 'Email verified',
        value: user.emailVerified.toString(),
      ),
      InfoCardCellContent(
        name: 'OTP enabled',
        value: user.otpEnabled.toString(),
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
            title: '${user.firstName} ${user.lastName}',
            description: user.email,
            actions: const ['actions', 'block', 'delete'],
          ),
          const Gap(16),
          InfoCard(
            title: 'General Information', width: infoCardWidth,
            items: _buildUserGeneralCardItems(theme),
          ),
          const Gap(16),
          InfoCard(
            title: 'Extra Information', width: infoCardWidth,
            items: _buildUserExtraCardItems(),
          ),
        ],
      ),

      
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const PageHeader(
      //       title: 'Dashboard',
      //       description: 'A summary of key data and insights on your project.',
      //     ),
      //     const Gap(16),
      //     if (responsive.isMobile)
      //       ...summaryCards
      //     else
      //       Row(
      //         children: summaryCards
      //             .map<Widget>((card) => Expanded(child: card))
      //             .intersperse(const Gap(16))
      //             .toList(),
      //       ),
      //     const Gap(16),
      //     const Expanded(
      //       child: _TableView(),
      //     ),
      //   ],
      // ),
    );
  }
}
