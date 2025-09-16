import 'package:flutter/material.dart';
import 'package:genesis/src/layer_presentation/pages/main_page/widgets/projects_summary_card.dart';
import 'package:genesis/src/layer_presentation/pages/main_page/widgets/verified_users_card.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/active_users_card.dart';

class _DashboardView extends StatelessWidget {
  const _DashboardView({super.key});

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        spacing: 24.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: [
              Expanded(
                // width: 200,
                // height: 100,
                child: ActiveUsersCard(),
              ),
              Expanded(
                // width: 200,
                // height: 100,
                child: VerifiedUsersCountCard(),
              ),
              Expanded(
                // width: 200,
                // height: 100,
                child: ProjectsSummaryCard(),
              ),
              // Flexible(
              //   child: SummaryCard(
              //     title: 'Resource Usage',
              //     value: '62.3%',
              //     secondaryTitle: '',
              //     secondaryValue: '',
              //   ),
              // ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text('Dashboard content goes here', style: TextStyle(fontSize: 24)),
            ),
          ),
          // Expanded(child: AppTableView()),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DashboardView();
  }
}
