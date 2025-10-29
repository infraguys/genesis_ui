import 'package:genesis/src/features/extensions/domain/entities/extension.dart';
import 'package:genesis/src/features/extensions/domain/params/get_extensions_params.dart';
import 'package:genesis/src/features/extensions/domain/repositories/i_extensions_repository.dart';

final class GetExtensionsUseCase {
  GetExtensionsUseCase(this._repository);

  final IExtensionsRepository _repository;

  Future<List<Extension>> call(GetExtensionsParams params) async {
    return await _repository.getExtensions(params);
  }
}
