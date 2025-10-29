import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/extensions/domain/entities/extension.dart';

abstract class ExtensionsEndpoints {
  static Endpoint items() {
    return Endpoint.withCorePrefix('/em/elements/');
  }

  static Endpoint item(ExtensionID id) {
    return Endpoint.withCorePrefix('/em/elements/$id');
  }
}
