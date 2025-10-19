import 'package:genesis/src/features/extensions/data/requests/get_extensions_req.dart';
import 'package:genesis/src/features/extensions/data/source/extensions_api.dart';
import 'package:genesis/src/features/extensions/domain/entities/extension.dart';
import 'package:genesis/src/features/extensions/domain/params/get_extensions_params.dart';
import 'package:genesis/src/features/extensions/domain/repositories/i_extensions_repository.dart';

final class ExtensionsRepository implements IExtensionsRepository {
  ExtensionsRepository(this._api);

  final ExtensionsApi _api;

  @override
  Future<Extension> getExtension(ExtensionID id) {
    // TODO: implement getExtension
    throw UnimplementedError();
  }

  @override
  Future<List<Extension>> getExtensions(GetExtensionsParams params) async {
    final dtos = await _api.getExtensions(GetExtensionsReq(params));
    return dtos.map((dto) => dto.toEntity()).toList();
  }
}
