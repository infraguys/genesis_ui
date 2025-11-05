part of '../cluster_list_page.dart';

class _CreateClusterButton extends StatelessWidget {
  const _CreateClusterButton({super.key}) : _isEmptyState = false; // ignore: unused_element_parameter


  // todo(Koretsky): Подумать над унификацией с другими кнопками создания
  const _CreateClusterButton.forEmptyState({super.key}) : _isEmptyState = true;

  final bool _isEmptyState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClustersBloc, ClustersState>(
      builder: (context, state) {
        if (state is ClustersLoadedState && state.clusters.isEmpty && !_isEmptyState) {
          return const SizedBox.shrink();
        }
        return CreateIconButton(
          onPressed: () async {
            await showDialog<void>(
              context: context,
              builder: (context) => Dialog(child: CreateClusterDialog()),
            );
          },
        );
      },
    );
  }
}
