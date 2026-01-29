import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/extensions_endpoints.dart';
import 'package:genesis/src/features/extensions/data/json_converters/extension_status_converter.dart';
import 'package:genesis/src/features/extensions/domain/params/get_extensions_params.dart';

final class GetExtensionsReq extends IRequest {
  const GetExtensionsReq(this._params);

  final GetExtensionsParams _params;

  @override
  Map<String, dynamic> get query {
    return {
      'name': ?_params.name,
      'description': ?_params.description,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
      'status': ?ExtensionStatusConverter().toJson(_params.status),
      'version': ?_params.version,
      'install_type': ?_params.installType,
      'link': ?_params.link,
    };
  }

  @override
  String get path {
    return ExtensionsEndpoints.items().fullPath;
  }
}
