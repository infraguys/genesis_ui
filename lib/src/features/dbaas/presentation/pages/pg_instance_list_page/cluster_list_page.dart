import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/pg_instance_list_page/blocs/cluster_selection_cubit.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/clusters_bloc/clusters_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/create_pg_instance_page/create_pg_instance_page.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/pg_instance_list_page/widgets/clusters_table.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/create_icon_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/delete_elevated_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/page_layout.dart';

part 'widgets/delete_clusters_btn.dart';

part 'widgets/create_cluster_btn.dart';

class _View extends StatelessWidget {
  const _View({
    super.key, // ignore: unused_element_parameter
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClustersBloc, ClustersState>(
      listenWhen: (_, current) => current.shouldListen,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case ClustersDeletedState(clusters: final instances) when instances.length == 1:
            messenger.showSnackBar(AppSnackBar.success(context.$.msgClusterDeleted(instances.single.name)));
          case ClustersDeletedState(clusters: final instances) when instances.length > 1:
            messenger.showSnackBar(AppSnackBar.success(context.$.msgClustersDeleted(instances.length)));

          default:
        }
      },
      child: PageLayout(
        breadcrumbs: [
          BreadcrumbItem(text: context.$.clusters),
        ],
        buttons: [
          _DeleteClustersButton(),
          _CreateClusterButton(),
        ],
        child: BlocBuilder<ClustersBloc, ClustersState>(
          buildWhen: (_, current) => current is ClustersLoadingState || current is ClustersLoadedState,
          builder: (_, state) {
            return switch (state) {
              _ when state is! ClustersLoadedState => AppProgressIndicator(),
              _ => ClustersTable(clusters: state.clusters),
            };
          },
        ),
      ),
    );
  }
}

class ClustersListPage extends StatefulWidget {
  const ClustersListPage({super.key});

  @override
  State<ClustersListPage> createState() => _ClustersListPageState();
}

class _ClustersListPageState extends State<ClustersListPage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    instancesObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  // Экран стал видимым (вернулись назад / сняли перекрытие)
  @override
  void didPopNext() {
    context.read<ClustersBloc>().add(ClustersEvent.startPolling());
  }

  // Поверх запушили другой экран — можно приостановить
  @override
  void didPushNext() {
    context.read<ClustersBloc>().add(ClustersEvent.stopPolling());
  }

  @override
  void dispose() {
    instancesObserver.unsubscribe(this);
    context.read<ClustersBloc>().add(ClustersEvent.stopPolling());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ClusterSelectionCubit(),
        ),
      ],
      child: _View(),
    );
  }
}
