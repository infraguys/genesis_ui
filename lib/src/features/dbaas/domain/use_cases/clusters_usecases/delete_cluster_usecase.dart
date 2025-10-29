import 'package:genesis/src/features/dbaas/domain/params/clusters_params/cluster_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';

final class DeleteClusterUseCase {
  DeleteClusterUseCase(this._repository);

  final IClustersRepository _repository;

  Future<void> call(ClusterParams params) async {
    await _repository.deleteCluster(params);
  }
}
