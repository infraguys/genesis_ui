import 'package:genesis/src/features/clusters/domain/entities/cluster.dart';
import 'package:genesis/src/features/clusters/domain/params/create_cluster_params.dart';
import 'package:genesis/src/features/clusters/domain/repositories/i_clusters_repository.dart';

final class CreateClusterUseCase {
  CreateClusterUseCase(this._repository);

  final IClustersRepository _repository;

  Future<Cluster> call(CreateClusterParams params) {
    return _repository.createCluster(params);
  }
}
