import 'package:genesis/src/layer_data/requests/extensions_requests/get_extensions_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_extensions_api.dart';
import 'package:genesis/src/layer_domain/entities/extension.dart';
import 'package:genesis/src/layer_domain/params/extensions_params/get_extensions_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_extensions_repository.dart';

final class ExtensionsRepository implements IExtensionsRepository {
  ExtensionsRepository(this._api);

  final IExtensionsApi _api;

  @override
  Future<Extension> getExtension(ExtensionUUID uuid) {
    // TODO: implement getExtension
    throw UnimplementedError();
  }

  @override
  Future<List<Extension>> getExtensions(GetExtensionsParams params) async {
    final dtos = await _api.getExtensions(GetExtensionsReq(params));
    return dtos.map((dto) => dto.toEntity()).toList();
  }
}
