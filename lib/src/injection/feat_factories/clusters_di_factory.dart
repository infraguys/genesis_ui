import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/dbaas/data/repositories/clusters_repository.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/clusters_api.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/clusters_bloc/clusters_bloc.dart';

final class ClustersDiFactory {
  /// Repositories

  ClustersRepository createClustersRepository(BuildContext context) {
    final clustersApi = ClustersApi(context.read<RestClient>());
    return ClustersRepository(clustersApi);
  }

  /// Blocs

  ClustersBloc createClustersBloc(BuildContext context) {
    return ClustersBloc(context.read<IClustersRepository>());
  }
}
