import 'package:genesis/src/core/interfaces/i_base_storage_client.dart';

abstract interface class ISecureStorageClient implements IBaseStorageClient {
  @override
  Future<void> write({required String key, required String value});

  @override
  Future<String?> read(String key);

  @override
  Future<void> delete(String key);
}
