import 'package:genesis/src/features/dbaas/data/requests/clusters_requests/cluster_req.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/clusters_api.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';

final class ClustersRepository implements IClustersRepository {
  ClustersRepository(this._api);

  final ClustersApi _api;

  @override
  Future<void> deleteCluster(params) async {
    _api.deleteCluster(params);
  }

  @override
  Future<Cluster> getCluster(params) async {
    final dto = await _api.getCluster(params);
    return dto.toEntity();
  }

  @override
  Future<List<Cluster>> getClusters(params) async {
    final dtos = await _api.getClusters(params);
    return dtos.map((it) => it.toEntity()).toList();
  }

  @override
  Future<Cluster> createCluster(params) async {
    final dto = await _api.createCluster(params);
    return dto.toEntity();
  }

  @override
  Future<Cluster> updateCluster(params) async {
    final dto = await _api.updateCluster(params);
    return dto.toEntity();
  }
}
