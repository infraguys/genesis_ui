import 'package:genesis/src/features/clusters/domain/entities/cluster.dart';
import 'package:genesis/src/features/clusters/domain/params/update_cluster_params.dart';
import 'package:genesis/src/features/clusters/domain/repositories/i_clusters_repository.dart';

final class UpdateClusterUseCase {
  UpdateClusterUseCase(this._repository);

  final IClustersRepository _repository;

  Future<Cluster> call(UpdateClusterParams params) async {
    return await _repository.updateCluster(params);
  }
}
