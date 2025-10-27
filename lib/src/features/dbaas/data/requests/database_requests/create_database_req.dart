import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/database_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/create_database_params.dart';

final class CreateDatabaseReq implements JsonEncodable, PathEncodable {
  CreateDatabaseReq(this._params);

  final CreateDatabaseParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'owner': _params.owner,
      'description': ?_params.description,
    };
  }

  @override
  String toPath() {
    return DatabaseEndpoints.items(_params.instanceId).fullPath;
  }
}
