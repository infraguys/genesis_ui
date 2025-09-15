part of '../nodes_page.dart';

class _DeleteNodesElevatedButton extends StatelessWidget {
  const _DeleteNodesElevatedButton({super.key});

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
                  message: context.$.deleteNodes(state.length),
                  onDelete: () {},
                );
              },
            );
          },
        );
      },
    );
  }
}
