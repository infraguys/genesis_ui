part of '../cluster_page.dart';

class _DeletePgInstanceButton extends StatelessWidget {
  const _DeletePgInstanceButton({required this.instance, super.key}); // ignore: unused_element_parameter

  final Cluster instance;

  @override
  Widget build(BuildContext context) {
    return DeleteElevatedButton(
      onPressed: () async {
        final pgInstanceBloc = context.read<ClusterBloc>();
        final message = context.$.deleteNodeConfirmation(instance.name);
        await showDialog<void>(
          context: context,
          builder: (_) => ConfirmationDialog(
            message: message,
            onDelete: () => pgInstanceBloc.add(ClusterEvent.delete(instance)),
          ),
        );
      },
    );
  }
}
