import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';

final class ApiUrlDao {
  ApiUrlDao(this._client);

  final ISimpleStorageClient _client;

  static const _apiUrlKey = 'api_url';

  Future<void> deleteApiUrl() async {
    await _client.delete(_apiUrlKey);
  }

  Future<String?> readApiUrl() async {
    return await _client.read(_apiUrlKey);
  }

  Future<void> writeApiUrl(String value) async {
    await _client.write(key: _apiUrlKey, value: value);
  }
}
