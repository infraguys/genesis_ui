part of '../pg_user_page.dart';

class _DeleteDatabasesButton extends StatelessWidget {
  const _DeleteDatabasesButton({
    required this.clusterId,
    super.key, // ignore: unused_element_parameter
  });

  final ClusterID clusterId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabasesSelectionCubit, List<Database>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }

        final message = switch (state.length) {
          1 => context.$.deleteDatabaseConfirmation(state.single.name),
          final len => context.$.deleteDatabasesConfirmation(len),
        };

        return DeleteElevatedButton(
          onPressed: () async {
            final databasesBloc = context.read<DatabasesBloc>();
            await showDialog<void>(
              context: context,
              builder: (_) => ConfirmationDialog(
                message: message,
                onDelete: () => databasesBloc.add(
                  DatabasesEvent.deleteDatabases(clusterId: clusterId, databases: state),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
