import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/extensions/data/repositories/extensions_repository.dart';
import 'package:genesis/src/features/extensions/data/source/extensions_api.dart';
import 'package:genesis/src/features/extensions/domain/usecases/get_extensions_usecase.dart';
import 'package:genesis/src/features/extensions/presentation/blocs/extensions_bloc/extensions_bloc.dart';

final class ExtensionsDiFactory {
  /// Repositories
  ///
  ExtensionsRepository makeExtensionsRepository(BuildContext context) {
    final extensionApi = ExtensionsApi(context.read<RestClient>());
    return ExtensionsRepository(extensionApi);
  }

  /// Blocs
  ///
  ExtensionsBloc makeExtensionsBloc(BuildContext context) {
    final repository = context.read<ExtensionsRepository>();
    return ExtensionsBloc(
      getExtensionsUseCase: GetExtensionsUseCase(repository)
    );
  }
}
