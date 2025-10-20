import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instance_selection_cubit/pg_instance_selection_cubit.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instances_bloc/pg_instances_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_table.dart';
import 'package:genesis/src/features/dbaas/presentation/widgets/pg_instance_status_widget.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class PgInstancesTable extends StatelessWidget {
  const PgInstancesTable({
    required this.instances,
    this.allowMultiSelect = true,
    super.key,
  });

  final List<PgInstance> instances;
  final bool allowMultiSelect;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PgInstancesBloc, PgInstancesState>(
      listenWhen: (_, current) => current is PgInstancesDeletedState,
      listener: (context, state) {
        context.read<PgInstanceSelectionCubit>().onClear();
      },
      child: AppTable(
        length: instances.length,
        columnSpans: [
          TableSpan(extent: FixedSpanExtent(40.0)),
          TableSpan(extent: FractionalSpanExtent(2 / 10)),
          TableSpan(extent: FractionalSpanExtent(2 / 10)),
          TableSpan(extent: FractionalSpanExtent(4 / 10)),
          TableSpan(extent: FractionalSpanExtent(2 / 10)),
          TableSpan(extent: FixedSpanExtent(56.0)),
        ],
        headerCells: [
          BlocBuilder<PgInstanceSelectionCubit, List<PgInstance>>(
            builder: (context, state) {
              return Checkbox(
                tristate: true,
                onChanged: (_) {
                  if (allowMultiSelect) {
                    context.read<PgInstanceSelectionCubit>().onToggleAll(instances);
                  }
                },
                value: switch (state.length) {
                  0 => false,
                  final len when len == instances.length => true,
                  _ => null,
                },
              );
            },
          ),
          Text(context.$.user, style: TextStyle(color: Colors.white)),
          Text(context.$.status, style: TextStyle(color: Colors.white)),
          Text(context.$.uuid, style: TextStyle(color: Colors.white)),
          Text(context.$.createdAt, style: TextStyle(color: Colors.white)),
        ],
        cellsBuilder: (index) {
          final instance = instances[index];
          return [
            BlocBuilder<PgInstanceSelectionCubit, List<PgInstance>>(
              builder: (context, state) {
                return Checkbox(
                  value: state.contains(instance),
                  onChanged: (_) {
                    if (!allowMultiSelect) {
                      context.read<PgInstanceSelectionCubit>().onClear();
                    }
                    context.read<PgInstanceSelectionCubit>().onToggle(instance);
                  },
                );
              },
            ),
            Text(instance.name, style: TextStyle(color: Colors.white)),
            PgInstanceStatusWidget(status: instance.status),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SelectableText(
                      instance.id.raw,
                      style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
                    ),
                  ),
                  WidgetSpan(child: const SizedBox(width: 8)),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: IconButton(
                      icon: Icon(Icons.copy, color: Colors.white, size: 18),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: instance.id.raw));
                        final snack = SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(context.$.msgCopiedToClipboard(instance.id.raw)),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snack);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Text(
              DateFormat('dd.MM.yyyy HH:mm').format(instance.createdAt),
              style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.robotoMono().fontFamily),
            ),
            SizedBox.shrink(),
          ];
        },
        onTap: (index) {
          final instance = instances[index];
          context.goNamed(
            AppRoutes.instance.name,
            pathParameters: {'id': instance.id.raw},
          );
        },
      ),
    );
  }
}
