import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instance_selection_cubit/pg_instance_selection_cubit.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instances_bloc/pg_instances_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/pg_instance_list_page/widgets/pg_instances_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/create_icon_button.dart';
import 'package:go_router/go_router.dart';

part './widgets/delete_pg_instances_btn.dart';

class _PgInstanceListView extends StatelessWidget {
  const _PgInstanceListView({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return BlocListener<PgInstancesBloc, PgInstancesState>(
      listenWhen: (_, current) => current is! PgInstancesLoadingState,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case PgInstancesDeletedState(:final instances) when instances.length == 1:
            messenger.showSnackBar(AppSnackBar.success('Success'.hardcoded));
          case PgInstancesDeletedState(:final instances) when instances.length > 1:
            messenger.showSnackBar(AppSnackBar.success('Success'.hardcoded));

          default:
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Breadcrumbs(
            items: [
              BreadcrumbItem(text: 'instance'.hardcoded),
            ],
          ),
          const SizedBox(height: 24),
          ButtonsBar(
            children: [
              // SearchInput(),
              _DeletePgInstancesButton(),
              CreateIconButton(onPressed: () => context.goNamed(AppRoutes.createInstance.name)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<PgInstancesBloc, PgInstancesState>(
              buildWhen: (previous, current) => current is PgInstancesLoadingState || current is PgInstancesLoadedState,
              builder: (_, state) => switch (state) {
                PgInstancesLoadedState(:final instances) => PgInstancesTable(instances: instances),
                _ => AppProgressIndicator(),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PgInstancesListPage extends StatefulWidget {
  const PgInstancesListPage({super.key});

  @override
  State<PgInstancesListPage> createState() => _PgInstancesListPageState();
}

class _PgInstancesListPageState extends State<PgInstancesListPage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    instancesObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  // Экран стал видимым (вернулись назад / сняли перекрытие)
  @override
  void didPopNext() {
    context.read<PgInstancesBloc>().add(PgInstancesEvent.startPollingInstances());
  }

  // Поверх запушили другой экран — можно приостановить
  @override
  void didPushNext() {
    context.read<PgInstancesBloc>().add(PgInstancesEvent.stopPollingInstances());
  }

  @override
  void dispose() {
    instancesObserver.unsubscribe(this);
    context.read<PgInstancesBloc>().add(PgInstancesEvent.stopPollingInstances());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PgInstanceSelectionCubit(),
        ),
      ],
      child: _PgInstanceListView(),
    );
  }
}
