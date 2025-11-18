import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';

class FlutterSecureStorageClient implements ISecureStorageClient {
  const FlutterSecureStorageClient._(this._storage);

  final FlutterSecureStorage _storage;

  static FlutterSecureStorageClient init() {
    return FlutterSecureStorageClient._(FlutterSecureStorage());
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }
}
