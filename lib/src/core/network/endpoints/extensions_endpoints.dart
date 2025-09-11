abstract class ExtensionsEndpoints {
  static const _elements = '/em/elements/';
  static const _element = '/em/elements/:uuid';

  static String getExtensions() => _elements;

  static String createExtension() => _elements;

  static String getExtension(String uuid) => _element.fillUuid(uuid);

  static String updateExtension(String uuid) => _element.fillUuid(uuid);

  static String deleteExtension(String uuid) => _element.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(String uuid) => replaceFirst(':uuid', uuid);
}
