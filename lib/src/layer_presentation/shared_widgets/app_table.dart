import 'package:flutter/material.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class AppTable extends StatelessWidget {
  const AppTable({
    required this.columnSpans,
    required this.headerCells,
    required this.length,
    required this.cellsBuilder,
    required this.onTap,
    super.key,
  });

  final List<TableSpan> columnSpans;
  final List<Widget> headerCells;
  final int length;
  final List<Widget> Function(int index) cellsBuilder;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return TableView.builder(
          columnCount: headerCells.length,
          rowCount: length + 1,
          pinnedRowCount: 1,
          columnBuilder: (index) {
            const checkboxColumnPx = 40.0;
            final totalWidth = constraints.maxWidth;
            final rest = totalWidth - checkboxColumnPx;
            final remainingRatio = (rest / totalWidth).clamp(0.0, 1.0);
            late final TableSpanExtent scaledExtent;
            if (index > 0) {
              final span = columnSpans[index - 1];
              final extent = span.extent;
              scaledExtent = switch (extent) {
                FixedTableSpanExtent(:final pixels) => FixedTableSpanExtent(pixels * remainingRatio),
                FractionalTableSpanExtent(:final fraction) => FractionalTableSpanExtent(fraction * remainingRatio),
                _ => extent,
              };
            }

            return switch (index) {
              0 => TableSpan(extent: FixedSpanExtent(checkboxColumnPx)),
              _ => TableSpan(extent: scaledExtent),
            };
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
            return TableViewCell(
              child: ColoredBox(
                color: isStickyHeader ? Colors.white.withValues(alpha: 0.05) : Colors.transparent,
                child: GestureDetector(
                  onTap: vicinity.yIndex == 0 ? null : () => onTap(vicinity.yIndex - 1),
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

// class _AppTableHeaderDelegate extends SliverPersistentHeaderDelegate {
//   _AppTableHeaderDelegate({required this.title, this.headerLeading});
//
//   final Widget title;
//   final Widget? headerLeading;
//
//   @override
//   double get minExtent => 48.0;
//
//   @override
//   double get maxExtent => 48.0;
//
//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Material(
//       color: Theme.of(context).scaffoldBackgroundColor,
//       child: ListTile(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(8),
//             topRight: Radius.circular(8),
//           ),
//         ),
//         minTileHeight: maxExtent,
//         contentPadding: EdgeInsets.zero,
//         leading: headerLeading,
//         title: title,
//       ),
//     );
//   }
//
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
// }
