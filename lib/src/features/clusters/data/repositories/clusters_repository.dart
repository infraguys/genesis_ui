import 'package:genesis/src/features/clusters/data/requests/cluster_req.dart';
import 'package:genesis/src/features/clusters/data/requests/create_cluster_req.dart';
import 'package:genesis/src/features/clusters/data/requests/get_clusters_req.dart';
import 'package:genesis/src/features/clusters/data/requests/update_cluster_req.dart';
import 'package:genesis/src/features/clusters/data/source/remote/clusters_api.dart';
import 'package:genesis/src/features/clusters/domain/entities/cluster.dart';
import 'package:genesis/src/features/clusters/domain/repositories/i_clusters_repository.dart';

final class ClustersRepository implements IClustersRepository {
  ClustersRepository(this._api);

  final ClustersApi _api;

  @override
  Future<void> deleteCluster(id) async {
    _api.deleteCluster(ClusterReq(id));
  }

  @override
  Future<Cluster> getCluster(id) async {
    final dto = await _api.getCluster(ClusterReq(id));
    return dto.toEntity();
  }

  @override
  Future<List<Cluster>> getClusters(params) async {
    final dtos = await _api.getClusters(GetClustersReq(params));
    return dtos.map((it) => it.toEntity()).toList();
  }

  @override
  Future<Cluster> createCluster(params) async {
    final dto = await _api.createCluster(CreateClusterReq(params));
    return dto.toEntity();
  }

  @override
  Future<Cluster> updateCluster(params) async {
    final dto = await _api.updateCluster(UpdateClusterReq(params));
    return dto.toEntity();
  }
}
