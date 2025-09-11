import 'package:genesis/src/layer_data/dtos/extension_dto.dart';
import 'package:genesis/src/layer_data/requests/extensions_requests/get_extensions_req.dart';
import 'package:genesis/src/layer_domain/entities/extension.dart';

abstract interface class IExtensionsApi {
  Future<List<ExtensionDto>> getExtensions(GetExtensionsReq req);

  Future<ExtensionDto> getExtension(ExtensionUUID uuid);
}
