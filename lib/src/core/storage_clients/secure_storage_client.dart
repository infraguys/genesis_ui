import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';

class FlutterSecureStorageClient implements ISecureStorageClient {
  final _storage = FlutterSecureStorage();

  @override
  Future<void> deleteSecure(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<String?> readSecure(String key) async {
    final x = await _storage.read(key: key);
    return x;
  }

  @override
  Future<void> writeSecure({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }
}
