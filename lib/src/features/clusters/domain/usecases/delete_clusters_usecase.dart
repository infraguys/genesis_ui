import 'package:genesis/src/features/clusters/domain/entities/cluster.dart';
import 'package:genesis/src/features/clusters/domain/repositories/i_clusters_repository.dart';

final class DeleteClustersUseCase {
  DeleteClustersUseCase(this._repository);

  final IClustersRepository _repository;

  Future<void> call(List<ClusterID> ids) async {
    await Future.wait(
      ids.map(_repository.deleteCluster),
    );
  }
}
