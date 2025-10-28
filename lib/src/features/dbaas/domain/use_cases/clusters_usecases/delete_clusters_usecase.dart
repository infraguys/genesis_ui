import 'package:genesis/src/features/dbaas/domain/params/clusters_params/cluster_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';

final class DeleteClustersUseCase {
  DeleteClustersUseCase(this._repository);

  final IClustersRepository _repository;

  Future<void> call(List<ClusterParams> listOfParams) async {
    await Future.wait(
      listOfParams.map(_repository.deleteCluster),
    );
  }
}
