part of '../cluster_list_page.dart';

class _NoClustersWidget extends StatelessWidget {
  const _NoClustersWidget({
    super.key, // ignore: unused_element_parameter
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      icon: Icons.storage_rounded,
      title: 'Нет кластеров',
      subtitle: 'Создайте первый кластер, чтобы начать работу',
      button: _CreateClusterButton.forEmptyState(),
    );
  }
}
