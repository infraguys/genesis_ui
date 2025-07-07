import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/presentation/features/dashboard/presentation/widgets/table_view/table_view.dart';
import 'package:genesis/src/presentation/shared_widgets/active_users_card.dart';
import 'package:genesis/src/presentation/shared_widgets/page_header.dart';
import 'package:genesis/src/presentation/shared_widgets/summary_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Genesis Stage'.hardcoded,
            description: 'A summary of key data and insights on the installation.'.hardcoded,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            spacing: 10,
            children: [
              Flexible(
                child: SummaryCard(
                  title: 'Total Nodes',
                  value: 38.toString(),
                  secondaryTitle: 'Broken',
                  secondaryValue: '0',
                ),
              ),
              Flexible(child: ActiveUsersCard()),
              Flexible(
                child: SummaryCard(
                  title: 'Resource Usage',
                  value: '62.3%',
                  secondaryTitle: '',
                  secondaryValue: '',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(child: AppTableView()),
        ],
      ),
    );
  }
}
