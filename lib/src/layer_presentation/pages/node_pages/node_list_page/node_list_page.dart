import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/layer_presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/node_pages/create_node_page/create_node_page.dart';
import 'package:genesis/src/layer_presentation/pages/node_pages/node_list_page/blocs/nodes_selection_cubit/nodes_selection_cubit.dart';
import 'package:genesis/src/layer_presentation/pages/node_pages/node_list_page/widgets/nodes_table.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/create_icon_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/delete_elevated_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/page_layout.dart';

part './widgets/delete_nodes_btn.dart';

class _NodeListView extends StatelessWidget {
  const _NodeListView({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return BlocListener<NodesBloc, NodesState>(
      listenWhen: (_, current) => current is NodesLoadedState,
      listener: (context, _) => context.read<NodesSelectionCubit>().onClear(),
      child: PageLayout(
        breadcrumbs: [
          BreadcrumbItem(text: context.$.nodes),
        ],
        buttons: [
          _DeleteNodesButton(),
          CreateIconButton(
            onPressed: () async {
              await showDialog<void>(
                context: context,
                builder: (context) => Dialog(child: CreateNodeDialog()),
              );
            },
          ),
        ],
        child: Expanded(
          child: BlocBuilder<NodesBloc, NodesState>(
            builder: (_, state) {
              return switch (state) {
                _ when state is! NodesLoadedState => AppProgressIndicator(),
                _ => NodesTable(nodes: state.nodes),
              };
            },
          ),
        ),
      ),
    );
  }
}

class NodeListPage extends StatelessWidget {
  const NodeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NodesSelectionCubit(),
      child: _NodeListView(),
    );
  }
}
