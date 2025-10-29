import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/get_clusters_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';

final class GetClustersUseCase {
  GetClustersUseCase(this._repository);

  final IClustersRepository _repository;

  Future<List<Cluster>> call(GetClustersParams params) {
    return _repository.getClusters(params);
  }
}
