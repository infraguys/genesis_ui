part of '../node_details_page.dart';

class _DeleteNodeElevatedButton extends StatelessWidget {
  const _DeleteNodeElevatedButton({required this.node, super.key});

  final Node node;

  @override
  Widget build(BuildContext context) {
    return DeleteElevatedButton(
      onPressed: () async {
        final nodeBloc = context.read<NodeBloc>();
        await showDialog<void>(
          context: context,
          builder: (context) {
            return ConfirmationDialog(
              message: context.$.deleteNode(node.name),
              onDelete: () {
                nodeBloc.add(NodeEvent.delete(node));
              },
            );
          },
        );
      },
    );
  }
}
