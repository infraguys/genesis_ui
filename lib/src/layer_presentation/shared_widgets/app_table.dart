import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTable<T> extends StatelessWidget {
  const AppTable({
    required this.entities,
    required this.item,
    required this.title,
    this.headerLeading,
    super.key,
  });

  final List<T> entities;
  final Widget item;
  final Widget title;
  final Widget? headerLeading;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: _AppTableHeaderDelegate(title: title, headerLeading: headerLeading),
          pinned: true,
        ),
        SliverList.separated(
          itemCount: entities.length,
          separatorBuilder: (_, _) => Divider(height: 0),
          itemBuilder: (context, index) {
            return Provider.value(
              value: entities[index],
              child: item,
            );
          },
        ),
      ],
    );
  }
}

class _AppTableHeaderDelegate extends SliverPersistentHeaderDelegate {
  _AppTableHeaderDelegate({required this.title, this.headerLeading});

  final Widget title;
  final Widget? headerLeading;

  @override
  double get minExtent => 48.0;

  @override
  double get maxExtent => 48.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        minTileHeight: maxExtent,
        contentPadding: EdgeInsets.zero,
        leading: headerLeading,
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert),
        ),
        title: title,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
