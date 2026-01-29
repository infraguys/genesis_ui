import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/clusters_endpoints.dart';
import 'package:genesis/src/features/clusters/domain/entities/cluster.dart';

final class ClusterReq extends IRequest {
  const ClusterReq(this._id);

  final ClusterID _id;

  @override
  String get path {
    return ClustersEndpoints.item(_id).fullPath;
  }
}
