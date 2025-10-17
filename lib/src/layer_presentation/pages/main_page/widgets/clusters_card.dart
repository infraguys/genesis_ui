import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instances_bloc/pg_instances_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';

class ClustersCard extends StatelessWidget {
  const ClustersCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Clusters', style: textTheme.titleMedium),
            BlocBuilder<PgInstancesBloc, PgInstancesState>(
              builder: (context, state) {
                if (state is! PgInstancesLoadedState) {
                  return Text(
                    'Loading...',
                    style: textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                  );
                }
                final clusters = state.instances;

                return Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'New:',
                            style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            state.newCount.toString(),
                            style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Active:',
                            style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            state.activeCount.toString(),
                            style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 16.0, left: 4.0, right: 4.0),
                          child: Text(
                            'In progress:',
                            style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 16.0, left: 4.0, right: 4.0),
                          child: Text(
                            state.inProgressCount.toString(),
                            style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Palette.color1B1B1D),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 4.0, left: 4.0, right: 4.0),
                          child: Text(
                            'Total:',
                            style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 4.0, left: 4.0, right: 4.0),
                          child: Text(
                            clusters.length.toString(),
                            style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
