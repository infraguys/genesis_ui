import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/common/shared_widgets/summary_card.dart';
import 'package:genesis/src/features/dashboard/presentation/widgets/table_view/table_view.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/features/users/presentation/widgets/active_users_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<UsersBloc>().add(UsersEvent.getUsers());
    super.initState();
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
