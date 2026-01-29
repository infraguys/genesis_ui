import 'package:genesis/src/features/clusters/domain/entities/cluster.dart';
import 'package:genesis/src/features/clusters/domain/params/get_clusters_params.dart';
import 'package:genesis/src/features/clusters/domain/repositories/i_clusters_repository.dart';

final class GetClustersUseCase {
  GetClustersUseCase(this._repository);

  final IClustersRepository _repository;

  Future<List<Cluster>> call(GetClustersParams params) {
    return _repository.getClusters(params);
  }
}
