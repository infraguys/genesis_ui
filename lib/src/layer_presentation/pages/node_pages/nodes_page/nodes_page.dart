import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/node_pages/nodes_page/blocs/nodes_selection_cubit/nodes_selection_cubit.dart';
import 'package:genesis/src/layer_presentation/pages/node_pages/nodes_page/widgets/nodes_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/create_icon_button.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class _NodesView extends StatelessWidget {
  const _NodesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Breadcrumbs(
          items: [
            BreadcrumbItem(text: context.$.nodes),
          ],
        ),
        ButtonsBar(
          children: [
            // SearchInput(),
            CreateIconButton(onPressed: () => context.goNamed(AppRoutes.createNode.name)),
          ],
        ),
        Expanded(
          child: BlocConsumer<NodesBloc, NodesState>(
            listenWhen: (_, current) => current is NodesLoadedState,
            listener: (context, _) {
              context.read<NodesSelectionCubit>().onClear();
            },
            builder: (_, state) => switch (state) {
              NodesLoadedState(:final nodes) => NodesTable(nodes: nodes),
              _ => AppProgressIndicator(),
            },
          ),
        ),
      ],
    );
  }
}

class NodesPage extends StatelessWidget {
  const NodesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NodesSelectionCubit(),
      child: _NodesView(key: key),
    );
  }
}
