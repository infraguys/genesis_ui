import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/create_cluster_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';

final class CreateClusterUseCase {
  CreateClusterUseCase(this._repository);

  final IClustersRepository _repository;

  Future<Cluster> call(CreateClusterParams params) {
    return _repository.createCluster(params);
  }
}
