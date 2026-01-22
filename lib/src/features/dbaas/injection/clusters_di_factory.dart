import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/dbaas/data/repositories/clusters_repository.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/clusters_api.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/clusters_usecases/delete_clusters_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/clusters_usecases/get_clusters_usecase.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/clusters_bloc/clusters_bloc.dart';

final class ClustersDiFactory {
  /// Repositories

  ClustersRepository makeClustersRepository(BuildContext context) {
    final clustersApi = ClustersApi(context.read<RestClient>());
    return ClustersRepository(clustersApi);
  }

  /// Blocs

  ClustersBloc makeClustersBloc(BuildContext context) {
    final repository = context.read<IClustersRepository>();
    return ClustersBloc(
      getClustersUseCase: GetClustersUseCase(repository),
      deleteClustersUseCase: DeleteClustersUseCase(repository),
    );
  }
}
