import 'package:genesis/src/features/extensions/domain/entities/extension.dart';
import 'package:genesis/src/features/extensions/domain/params/get_extensions_params.dart';

abstract interface class IExtensionsRepository {
  Future<List<Extension>> getExtensions(GetExtensionsParams params);

  Future<Extension> getExtension(ExtensionID id);
}
