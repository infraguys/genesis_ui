part of '../node_details_page.dart';

class _DeleteNodeButton extends StatelessWidget {
  const _DeleteNodeButton({required this.node, super.key}); // ignore: unused_element_parameter

  final Node node;

  @override
  Widget build(BuildContext context) {
    return DeleteElevatedButton(
      onPressed: () async {
        final nodeBloc = context.read<NodeBloc>();
        final message = context.$.deleteNodeConfirmation(node.name);
        await showDialog<void>(
          context: context,
          builder: (_) => ConfirmationDialog(
            message: message,
            onDelete: () => nodeBloc.add(NodeEvent.delete(node)),
          ),
        );
      },
    );
  }
}
