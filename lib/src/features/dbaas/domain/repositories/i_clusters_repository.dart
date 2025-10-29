import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/cluster_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/create_cluster_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/get_clusters_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/update_cluster_params.dart';

abstract interface class IClustersRepository {
  Future<List<Cluster>> getClusters(GetClustersParams params);

  Future<Cluster> getCluster(ClusterParams params);

  Future<Cluster> createCluster(CreateClusterParams params);

  Future<Cluster> updateCluster(UpdateClusterParams params);

  Future<void> deleteCluster(ClusterParams params);
}
