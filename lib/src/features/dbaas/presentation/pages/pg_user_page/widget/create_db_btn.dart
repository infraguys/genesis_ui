part of '../pg_user_page.dart';

class _CreateDbButton extends StatelessWidget {
  const _CreateDbButton({
    required this.clusterId,
    required this.pgUserId,
    super.key,
  });

  final ClusterID clusterId;
  final PgUserID pgUserId;

  @override
  Widget build(BuildContext context) {
    return CreateIconButton(
      onPressed: () async {
        final bloc = context.read<DatabasesBloc>();
        await showDialog<PgUser>(
          context: context,
          builder: (context) => Dialog(
            child: BlocProvider.value(
              value: bloc,
              child: CreateDatabaseDialog(
                clusterId: clusterId,
                pgUserId: pgUserId,
              ),
            ),
          ),
        );
      },
    );
  }
}
