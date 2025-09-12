import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/core/network/endpoints/extensions_endpoints.dart';
import 'package:genesis/src/layer_domain/params/extensions_params/get_extensions_params.dart';

final class GetExtensionsReq implements QueryEncodable, PathEncodable {
  GetExtensionsReq(this._params);

  final GetExtensionsParams _params;

  @override
  Map<String, dynamic> toQuery() {
    return {
      'name': ?_params.name,
      'description': ?_params.description,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
      'status': ?_params.status,
      'version': ?_params.version,
      'install_type': ?_params.installType,
      'link': ?_params.link,
    };
  }

  @override
  String toPath() {
    return ExtensionsEndpoints.getExtensions();
  }
}
