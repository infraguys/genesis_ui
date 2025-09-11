import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/repositories/i_extensions_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/extensions_bloc/extensions_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/extensions_page/widgets/extensions_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';

class _ExtensionsView extends StatelessWidget {
  const _ExtensionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Breadcrumbs(
          items: [
            BreadcrumbItem(text: context.$.organizations),
          ],
        ),
        const SizedBox(height: 24),
        ButtonsBar.withoutLeftSpacer(
          children: [
            // SearchInput(),
            Spacer(),
          ],
        ),
        const SizedBox(height: 24),
        Expanded(
          child: BlocConsumer<ExtensionsBloc, ExtensionsState>(
            listener: (context, _) {},
            builder: (_, state) => switch (state) {
              ExtensionsLoadedState(:final extensions) => ExtensionsTable(extensions: extensions),
              _ => AppProgressIndicator(),
            },
          ),
        ),
      ],
    );
  }
}

class ExtensionsPage extends StatelessWidget {
  const ExtensionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ExtensionsBloc(context.read<IExtensionsRepository>())..add(
          ExtensionsEvent.getExtensions(),
        );
      },
      child: _ExtensionsView(),
    );
  }
}
