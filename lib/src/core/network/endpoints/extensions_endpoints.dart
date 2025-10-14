import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/layer_domain/entities/extension.dart';

abstract class ExtensionsEndpoints {
  static const _elements = '${Env.apiPrefix}/${Env.versionApi}/em/elements/';
  static const _element = '$_elements:id';

  static String getExtensions() => _elements;

  static String createExtension() => _elements;

  static String getExtension(ExtensionID id) => _element.fillUuid(id);

  static String updateExtension(ExtensionID id) => _element.fillUuid(id);

  static String deleteExtension(ExtensionID id) => _element.fillUuid(id);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(ExtensionID id) => replaceFirst(':id', id.value);
}
