import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class InfoCardCellContent {
  const InfoCardCellContent({
    required this.name,
    required this.value,
    this.valueFilling = false,
    this.valueColor,
  });
  
  final String name;
  final String value;
  final bool valueFilling;
  final Color? valueColor;

  Widget nameWidget(ThemeData theme) {
    return Text(
      name,
      style: theme.textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w200,
      ),
      selectionColor: theme.colorScheme.primary,
    );
  }

  Widget valueWidget(ThemeData theme) {
    if (valueFilling) {
      return Container(
        padding: const EdgeInsets.only(
          left: 8, right: 8, top: 3, bottom: 3,
        ), // Add some padding around the text
        decoration: BoxDecoration(
          color: valueColor ?? theme.colorScheme.primary, // Internal color fill
          borderRadius: BorderRadius.circular(10), // Rounded border corners
        ),
        child: Text(
          value,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onPrimary,
          ),
        ),
      );
    }

    return Text(
      value,
      style: theme.textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w600,
      ),
      selectionColor: theme.colorScheme.primary,
    );
  }
}


class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.width,
    required this.items,
  });

  final String title;
  final int width;
  final List<InfoCardCellContent> items;

  List<TableRow> _buildTableRows(ThemeData theme) {
    final tableWidgets = <TableRow>[];
    var rowWidgets = <Widget>[];

    for (final item in items) {
      rowWidgets.add(
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item.nameWidget(theme),
              item.valueWidget(theme),
          ],)
        ,)
      ,);

      if (rowWidgets.length == width) {
        tableWidgets.add(TableRow(children: rowWidgets));
        rowWidgets = <Widget>[];
      }

    }

    if (rowWidgets.isNotEmpty) {
      for (var i = rowWidgets.length; i < width; i++) {
        rowWidgets.add(Container());
      }

      tableWidgets.add(TableRow(children: rowWidgets));
    }

    return tableWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(title, style: theme.textTheme.titleLarge),
              ),
              const Gap(8),
              Table(
                children: _buildTableRows(theme),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
