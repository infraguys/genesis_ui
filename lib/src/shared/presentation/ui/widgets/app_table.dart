import 'package:flutter/material.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class AppTable extends StatelessWidget {
  const AppTable({
    required this.columnSpans,
    required this.headerCells,
    required this.length,
    required this.cellsBuilder,
    this.onTap,
    super.key,
  });

  final List<TableSpan> columnSpans;
  final List<Widget> headerCells;
  final int length;
  final List<Widget> Function(int index) cellsBuilder;
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        return TableView.builder(
          columnCount: columnSpans.length,
          rowCount: length + 1,
          pinnedRowCount: 1,
          columnBuilder: (index) {
            final fixedWidth = columnSpans.fold<double>(0, (previousValue, element) {
              final extent = element.extent;
              final currentValue = switch (extent) {
                FixedSpanExtent(:final pixels) => pixels,
                _ => 0,
              };
              return previousValue + currentValue;
            });

            final rest = totalWidth - (fixedWidth);
            final remainingRatio = (rest / totalWidth).clamp(0.0, 1.0);
            late final TableSpanExtent scaledExtent;
            if (index > 0 || index < columnSpans.length - 1) {
              final span = columnSpans[index];
              final extent = span.extent;

              scaledExtent = switch (extent) {
                FractionalSpanExtent(:final fraction) => FractionalSpanExtent(fraction * remainingRatio),
                _ => extent,
              };
            }

            if (index == 0) {
              return columnSpans[index];
            }
            if (index == columnSpans.length - 1) {
              return columnSpans[index];
            }
            return TableSpan(extent: scaledExtent);
          },
          rowBuilder: (index) => TableSpan(
            extent: const FixedTableSpanExtent(40),
            backgroundDecoration: SpanDecoration(
              border: SpanBorder(
                trailing: index > 0 ? BorderSide(color: Palette.color333333) : BorderSide.none,
              ),
            ),
          ),
          cellBuilder: (context, vicinity) {
            final isStickyHeader = vicinity.yIndex == 0;
            late final Widget child;
            if (vicinity.yIndex == 0) {
              child = headerCells[vicinity.xIndex];
            } else {
              final cellList = cellsBuilder(vicinity.yIndex - 1);
              child = cellList[vicinity.xIndex];
            }

            if (isStickyHeader && vicinity.xIndex == 4) {
              return TableViewCell(
                columnMergeSpan: 2,
                columnMergeStart: 4,
                child: ColoredBox(
                  color: Palette.color333333,
                  child: GestureDetector(
                    onTap: vicinity.yIndex == 0 ? null : () => onTap?.call(vicinity.yIndex - 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: child,
                      ),
                    ),
                  ),
                ),
              );
            }

            return TableViewCell(
              child: ColoredBox(
                color: isStickyHeader ? Palette.color333333 : Colors.transparent,
                child: GestureDetector(
                  onTap: vicinity.yIndex == 0 ? null : () => onTap?.call(vicinity.yIndex - 1),
                  child: MouseRegion(
                    cursor: isStickyHeader ? SystemMouseCursors.basic : SystemMouseCursors.click,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
