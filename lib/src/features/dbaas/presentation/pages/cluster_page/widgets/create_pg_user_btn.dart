part of '../cluster_page.dart';

class _CreatePgUserButton extends StatelessWidget {
  const _CreatePgUserButton({
    required this.id,
    super.key, // ignore: unused_element_parameter
  });

  final ClusterID id;

  @override
  Widget build(BuildContext context) {
    return CreateIconButton(
      onPressed: () async {
        final bloc = context.read<PgUsersBloc>();
        await showDialog<void>(
          context: context,
          builder: (_) => Dialog(
            child: BlocProvider.value(
              value: bloc,
              child: CreatePgUserDialog(clusterID: id),
            ),
          ),
        );
      },
    );
  }
}
