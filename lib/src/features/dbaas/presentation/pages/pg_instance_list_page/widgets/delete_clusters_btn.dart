part of '../cluster_list_page.dart';

class _DeleteClustersButton extends StatelessWidget {
  const _DeleteClustersButton({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClusterSelectionCubit, List<Cluster>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }

        final message = switch (state.length) {
          1 => context.$.deletePgClusterConfirmation(state.single.name),
          final len => context.$.deleteClustersConfirmation(len),
        };

        return DeleteElevatedButton(
          onPressed: () async {
            final clustersBloc = context.read<ClustersBloc>();
            await showDialog<void>(
              context: context,
              builder: (_) => ConfirmationDialog(
                message: message,
                onDelete: () => clustersBloc.add(ClustersEvent.deleteClusters(state)),
              ),
            );
          },
        );
      },
    );
  }
}
