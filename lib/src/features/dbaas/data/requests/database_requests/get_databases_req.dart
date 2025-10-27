import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/core/network/endpoints/database_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/get_databases_params.dart';

final class GetDatabasesReq implements PathEncodable, QueryEncodable {
  GetDatabasesReq(this._params);

  final GetDatabasesParams _params;

  @override
  Map<String, dynamic> toQuery() {
    return {};
  }

  @override
  String toPath() {
    return DatabaseEndpoints.items(_params.instanceId).fullPath;
  }
}
