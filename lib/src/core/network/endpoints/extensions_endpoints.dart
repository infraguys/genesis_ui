import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/layer_domain/entities/extension.dart';

abstract class ExtensionsEndpoints {
  static const _elements = '/${Env.versionApi}/em/elements/';
  static const _element = '/${Env.versionApi}/em/elements/:uuid';

  static String getExtensions() => _elements;

  static String createExtension() => _elements;

  static String getExtension(ExtensionUUID uuid) => _element.fillUuid(uuid);

  static String updateExtension(ExtensionUUID uuid) => _element.fillUuid(uuid);

  static String deleteExtension(ExtensionUUID uuid) => _element.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(ExtensionUUID uuid) => replaceFirst(':uuid', uuid.value);
}
