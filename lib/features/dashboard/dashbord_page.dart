import 'dart:async';

import 'package:flutter/material.dart';
import 'package:genesis_admin_dashboard_template/features/dashboard/dummy_inventories.dart';
import 'package:genesis_admin_dashboard_template/features/dashboard/inventory.dart';
import 'package:genesis_admin_dashboard_template/features/nodes/data.dart';
import 'package:genesis_admin_dashboard_template/features/iam/user_data.dart';
import 'package:gap/gap.dart';
import 'package:intersperse/intersperse.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../widgets/widgets.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {

  int totalNodes() {
    return genesisCoreNodes.length;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final summaryCards = [
      SummaryCard(
        title: 'Total Nodes',
        value: totalNodes().toString(),
        secondaryTitle: 'Broken',
        secondaryValue: '0',
      ),
      SummaryCard(title: 'Total Users', value: genesisUsers.length.toString()),
      SummaryCard(title: 'Resource Usage', value: '62.3%'),
    ];

    return ContentView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Genesis Stage',
            description: 'A summary of key data and insights on the installation.',
          ),
          const Gap(16),
          if (responsive.isMobile)
            ...summaryCards
          else
            Row(
              children: summaryCards
                  .map<Widget>((card) => Expanded(child: card))
                  .intersperse(const Gap(16))
                  .toList(),
            ),
          const Gap(16),
          Expanded(
            // child: EventListWidget(),
            child: _TableView(),
          ),
        ],
      ),
    );
  }
}

class EventListWidget extends StatefulWidget {
  const EventListWidget({
    super.key,
  });

  @override
  State<EventListWidget> createState() => _EventListWidgetState();
}

class _EventListWidgetState extends State<EventListWidget> {
  final GlobalKey<AnimatedListState> _eventListKey = GlobalKey<AnimatedListState>();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startPeriodicUpdate();
  }

  void _startPeriodicUpdate() {
    _timer = Timer.periodic(const Duration(seconds: 30), (Timer timer) {
      _updateData();
    });
  }

  void _updateData() {
    _eventListKey.currentState?.insertItem(0);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _eventListKey,
      initialItemCount: 0,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: animation.drive(Tween(begin: const Offset(0, -1), end: Offset.zero)),
          child: SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello"),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TableView extends StatelessWidget {
  const _TableView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final decoration = TableSpanDecoration(
      border: TableSpanBorder(
        trailing: BorderSide(color: theme.dividerColor),
      ),
    );
    final inventories = dummyInventories;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: TableView.builder(
        columnCount: Inventory.itemCount,
        rowCount: inventories.length,
        pinnedRowCount: 1,
        pinnedColumnCount: 1,
        columnBuilder: (index) {
          var fraction = 1 / 8; 
            switch (index) {
              case 0:
                fraction = 1 / 8;
              case 1:
                fraction = 11 / 16;
              case 2:
                fraction = 1 / 8;
              case 3:
                fraction = 1 / 16;
            }

          return TableSpan(
            foregroundDecoration: index == 0 ? decoration : null,
            extent: FractionalTableSpanExtent(fraction),
          );
        },
        rowBuilder: (index) {
          return TableSpan(
            foregroundDecoration: index == 0 ? decoration : null,
            extent: const FixedTableSpanExtent(50),
          );
        },
        cellBuilder: (context, vicinity) {
          final isStickyHeader = vicinity.xIndex == 0 || vicinity.yIndex == 0;
          var label = '';
          var alignment = Alignment.center;
          if (vicinity.yIndex == 0) {
            switch (vicinity.xIndex) {
              case 0:
                label = 'Event';
              case 1:
                label = 'Description';
                alignment = Alignment.centerLeft;
              case 2:
                label = 'time';
              case 3:
                label = 'Status';
            }
          } else {
            final inventory = inventories[vicinity.yIndex - 1];
            switch (vicinity.xIndex) {
              case 0:
                label = inventory.event;
              case 1:
                label = inventory.description;
                alignment = Alignment.centerLeft;
              case 2:
                label = inventory.time;
              case 3:
                label = inventory.status;
            }
          }
          return TableViewCell(
            child: ColoredBox(
              color:
                  isStickyHeader ? Colors.transparent : colorScheme.background,
              child: Align(
                alignment: alignment,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontWeight: isStickyHeader ? FontWeight.w600 : null,
                        color: isStickyHeader ? null : colorScheme.outline,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
