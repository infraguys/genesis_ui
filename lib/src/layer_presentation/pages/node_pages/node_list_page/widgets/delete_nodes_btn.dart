part of '../node_list_page.dart';

class _DeleteNodesButton extends StatelessWidget {
  const _DeleteNodesButton({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodesSelectionCubit, List<Node>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }

        final message = switch (state.length) {
          1 => context.$.deleteNodeConfirmation(state.single.name),
          final len => context.$.deleteNodesConfirmation(len),
        };

        return DeleteElevatedButton(
          onPressed: () async {
            final nodesBloc = context.read<NodesBloc>();
            await showDialog<void>(
              context: context,
              builder: (_) => ConfirmationDialog(
                message: message,
                onDelete: () => nodesBloc.add(NodesEvent.deleteNodes(state)),
              ),
            );
          },
        );
      },
    );
  }
}
