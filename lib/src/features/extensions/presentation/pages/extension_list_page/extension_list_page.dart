import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/extensions/presentation/blocs/extensions_bloc/extensions_bloc.dart';
import 'package:genesis/src/features/extensions/presentation/pages/extension_list_page/widgets/extensions_table.dart';
import 'package:genesis/src/injection/di_scope.dart';
import 'package:genesis/src/injection/main_di_factory.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';

class _ExtensionListView extends StatelessWidget {
  const _ExtensionListView({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Breadcrumbs(
          items: [
            BreadcrumbItem(text: context.$.elements),
          ],
        ),
        const SizedBox(height: 24),
        ButtonsBar(
          children: [
            // SearchInput(),
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

class ExtensionListPage extends StatelessWidget {
  const ExtensionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final diFactory = DiScope.of(context);
    return BlocProvider(
      create: (context) {
        return diFactory.extensions.makeExtensionsBloc(context)..add(
          ExtensionsEvent.getExtensions(),
        );
      },
      child: _ExtensionListView(),
    );
  }
}
