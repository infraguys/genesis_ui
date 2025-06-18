import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:genesis/src/core/secure_storage_client/i_secure_storage_client.dart';

final class SecureStorageClient implements ISecureStorageClient {
  SecureStorageClient(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<String?> read(String key) async {
    await _storage.read(key: key);
    return null;
  }

  @override
  Future<void> write({required String key, required String? value}) async {
    await _storage.write(key: key, value: value);
  }
}
