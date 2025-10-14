import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/pg_instances_pages/blocs/pg_instances_bloc/pg_instances_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/pg_instances_pages/pg_instance_list_page/widgets/pg_instances_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/create_icon_button.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class _PgInstanceListView extends StatelessWidget {
  const _PgInstanceListView({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return Column(
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
            CreateIconButton(onPressed: () => context.goNamed(AppRoutes.createInstance.name)),
          ],
        ),
        const SizedBox(height: 24),
        Expanded(
          child: BlocBuilder<PgInstancesBloc, PgInstancesState>(
            builder: (_, state) => switch (state) {
              PgInstancesLoadedState(:final instances) => PgInstancesTable(instances: instances),
              _ => AppProgressIndicator(),
            },
          ),
        ),
      ],
    );
  }
}

class PgInstancesListPage extends StatelessWidget {
  const PgInstancesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return PgInstancesBloc(context.read<IPgInstancesRepository>())..add(PgInstancesEvent.getInstances());
          },
        ),
      ],
      child: _PgInstanceListView(),
    );
  }
}
