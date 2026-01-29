import 'package:genesis/src/features/clusters/domain/entities/cluster.dart';
import 'package:genesis/src/features/clusters/domain/repositories/i_clusters_repository.dart';

final class GetClusterUseCase {
  GetClusterUseCase(this._repository);

  final IClustersRepository _repository;

  Future<Cluster> call(ClusterID id) async {
    return _repository.getCluster(id);
  }
}
