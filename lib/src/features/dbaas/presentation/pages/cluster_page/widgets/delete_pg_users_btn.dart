part of '../cluster_page.dart';

class _DeletePgUsersButton extends StatelessWidget {
  const _DeletePgUsersButton({
    required this.clusterId,
    super.key, // ignore: unused_element_parameter
  });

  final ClusterID clusterId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PgUsersSelectionCubit, List<PgUser>>(
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
            final pgUsersBloc = context.read<PgUsersBloc>();
            await showDialog<void>(
              context: context,
              builder: (_) => ConfirmationDialog(
                message: message,
                onDelete: () => pgUsersBloc.add(
                  PgUsersEvent.deleteUsers(pgUsers: state, clusterId: clusterId),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
