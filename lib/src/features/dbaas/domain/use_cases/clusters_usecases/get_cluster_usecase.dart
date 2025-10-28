import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/cluster_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';

final class GetClusterUseCase {
  GetClusterUseCase(this._repository);

  final IClustersRepository _repository;

  Future<Cluster> call(ClusterParams params) async {
    return _repository.getCluster(params);
  }
}
