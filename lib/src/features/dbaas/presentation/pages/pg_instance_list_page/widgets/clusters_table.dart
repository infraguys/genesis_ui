import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/cluster_selection_cubit/cluster_selection_cubit.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/clusters_bloc/clusters_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/widgets/cluster_status_widget.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_table.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class ClustersTable extends StatelessWidget {
  const ClustersTable({
    required this.clusters,
    this.allowMultiSelect = true,
    super.key,
  });

  final List<Cluster> clusters;
  final bool allowMultiSelect;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClustersBloc, ClustersState>(
      listenWhen: (_, current) => current is ClustersDeletedState,
      listener: (context, state) => context.read<ClusterSelectionCubit>().onClear(),
      child: AppTable(
        length: clusters.length,
        columnSpans: [
          TableSpan(extent: FixedSpanExtent(40.0)),
          TableSpan(extent: FractionalSpanExtent(2 / 10)),
          TableSpan(extent: FractionalSpanExtent(2 / 10)),
          TableSpan(extent: FractionalSpanExtent(4 / 10)),
          TableSpan(extent: FractionalSpanExtent(2 / 10)),
          TableSpan(extent: FixedSpanExtent(56.0)),
        ],
        headerCells: [
          BlocBuilder<ClusterSelectionCubit, List<Cluster>>(
            builder: (context, state) {
              return Checkbox(
                tristate: true,
                onChanged: (_) {
                  if (allowMultiSelect) {
                    context.read<ClusterSelectionCubit>().onToggleAll(clusters);
                  }
                },
                value: switch (state.length) {
                  0 => false,
                  final len when len == clusters.length => true,
                  _ => null,
                },
              );
            },
          ),
          Text(context.$.cluster, style: TextStyle(color: Colors.white)),
          Text(context.$.status, style: TextStyle(color: Colors.white)),
          Text(context.$.uuid, style: TextStyle(color: Colors.white)),
          Text(context.$.createdAt, style: TextStyle(color: Colors.white)),
        ],
        cellsBuilder: (index) {
          final instance = clusters[index];
          return [
            BlocBuilder<ClusterSelectionCubit, List<Cluster>>(
              builder: (context, state) {
                return Checkbox(
                  value: state.contains(instance),
                  onChanged: (_) {
                    if (!allowMultiSelect) {
                      context.read<ClusterSelectionCubit>().onClear();
                    }
                    context.read<ClusterSelectionCubit>().onToggle(instance);
                  },
                );
              },
            ),
            Text(instance.name, style: TextStyle(color: Colors.white)),
            ClusterStatusWidget(status: instance.status),
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
          final instance = clusters[index];
          context.goNamed(
            AppRoutes.instance.name,
            pathParameters: {'id': instance.id.raw},
          );
        },
      ),
    );
  }
}
