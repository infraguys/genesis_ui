import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/extensions/data/repositories/extensions_repository.dart';
import 'package:genesis/src/features/extensions/data/source/extensions_api.dart';

final class ExtensionsDiFactory {
  /// Repositories
  ExtensionsRepository createExtensionsRepository(BuildContext context) {
    final extensionApi = ExtensionsApi(context.read<RestClient>());
    return ExtensionsRepository(extensionApi);
  }
}
