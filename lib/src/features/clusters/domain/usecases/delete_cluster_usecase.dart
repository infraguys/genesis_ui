import 'package:genesis/src/features/clusters/domain/entities/cluster.dart';
import 'package:genesis/src/features/clusters/domain/repositories/i_clusters_repository.dart';

final class DeleteClusterUseCase {
  DeleteClusterUseCase(this._repository);

  final IClustersRepository _repository;

  Future<void> call(ClusterID id) async {
    await _repository.deleteCluster(id);
  }
}
