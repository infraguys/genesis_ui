part of '../node_list_page.dart';

class _DeleteNodesButton extends StatelessWidget {
  const _DeleteNodesButton({super.key});

  String createMessage(BuildContext context, List<Node> nodes) {
    if (nodes.length == 1) {
      // todo: перептсать на "confirmation"
      return context.$.deleteNode(nodes.single.name);
    } else {
      return context.$.deleteNodes(nodes.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodesSelectionCubit, List<Node>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }
        return DeleteElevatedButton(
          onPressed: () async {
            await showDialog<void>(
              context: context,
              builder: (context) {
                return ConfirmationDialog(
                  message: createMessage(context, state),
                  onDelete: () {
                    context.read<NodesBloc>().add(NodesEvent.deleteNodes(state));
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
