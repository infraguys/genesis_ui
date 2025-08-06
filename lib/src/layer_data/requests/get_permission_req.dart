import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:genesis/src/layer_domain/params/get_permissions_params.dart';

final class GetPermissionsReq implements QueryEncodable, PathEncodable {
  GetPermissionsReq(this._params);

  final GetPermissionsParams _params;

  @override
  Map<String, dynamic> toQuery() {
    final status = switch (_params.status) {
      Status.active => 'ACTIVE',
      _ => null,
    };

    return {
      'name': ?_params.name,
      'description': ?_params.description,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
      'status': ?status,
    };
  }

  @override
  String toPath(String prefix) => prefix;
}
