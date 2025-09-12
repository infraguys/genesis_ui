import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/layer_presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/node_pages/nodes_page/widgets/nodes_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';

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
            BreadcrumbItem(text: 'Nodes'.hardcoded),
          ],
        ),
        ButtonsBar.withoutLeftSpacer(
          children: [
            // SearchInput(),
            Spacer(),
          ],
        ),
        Expanded(
          child: BlocConsumer<NodesBloc, NodesState>(
            // listenWhen: (_, current) => current is UsersLoadedState,
            listener: (context, _) {
              // context.read<UsersSelectionBloc>().add(UsersSelectionEvent.clear());
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
    return _NodesView(key: key);
  }
}
