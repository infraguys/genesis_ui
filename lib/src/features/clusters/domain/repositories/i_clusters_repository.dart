import 'package:genesis/src/features/clusters/domain/entities/cluster.dart';
import 'package:genesis/src/features/clusters/domain/params/create_cluster_params.dart';
import 'package:genesis/src/features/clusters/domain/params/get_clusters_params.dart';
import 'package:genesis/src/features/clusters/domain/params/update_cluster_params.dart';

abstract interface class IClustersRepository {
  Future<List<Cluster>> getClusters(GetClustersParams params);

  Future<Cluster> getCluster(ClusterID params);

  Future<Cluster> createCluster(CreateClusterParams params);

  Future<Cluster> updateCluster(UpdateClusterParams params);

  Future<void> deleteCluster(ClusterID params);
}
