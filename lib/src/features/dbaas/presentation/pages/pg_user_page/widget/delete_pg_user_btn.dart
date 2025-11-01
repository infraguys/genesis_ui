part of '../pg_user_page.dart';

class _DeletePgUserButton extends StatelessWidget {
  const _DeletePgUserButton({
    required this.pgUser,
    required this.clusterId,
    super.key, // ignore: unused_element_parameter
  });

  final PgUser pgUser;
  final ClusterID clusterId;

  @override
  Widget build(BuildContext context) {
    return DeleteElevatedButton(
      onPressed: () async {
        final pgUserBloc = context.read<PgUserBloc>();
        final message = context.$.deletePgUserConfirmation(pgUser.name);

        await showDialog<void>(
          context: context,
          builder: (_) => ConfirmationDialog(
            message: message,
            onDelete: () => pgUserBloc.add(
              PgUserEvent.delete(
                params: PgUserParams(clusterId: clusterId, pgUserId: pgUser.id),
                pgUser: pgUser,
              ),
            ),
          ),
        );
      },
    );
  }
}
