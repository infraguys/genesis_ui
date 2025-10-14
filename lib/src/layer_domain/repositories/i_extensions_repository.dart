import 'package:genesis/src/layer_domain/entities/extension.dart';
import 'package:genesis/src/layer_domain/params/extensions_params/get_extensions_params.dart';

abstract interface class IExtensionsRepository {
  Future<List<Extension>> getExtensions(GetExtensionsParams params);

  Future<Extension> getExtension(ExtensionID id);
}
