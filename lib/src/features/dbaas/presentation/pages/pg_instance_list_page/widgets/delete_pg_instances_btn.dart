part of '../pg_instance_list_page.dart';

class _DeletePgInstancesButton extends StatelessWidget {
  const _DeletePgInstancesButton({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PgInstanceSelectionCubit, List<PgInstance>>(
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
            final nodesBloc = context.read<PgInstancesBloc>();
            await showDialog<void>(
              context: context,
              builder: (_) => ConfirmationDialog(
                message: message,
                onDelete: () => nodesBloc.add(PgInstancesEvent.deleteInstances(state)),
              ),
            );
          },
        );
      },
    );
  }
}
