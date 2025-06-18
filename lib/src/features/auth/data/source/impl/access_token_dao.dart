import 'package:genesis/src/core/secure_storage_client/i_secure_storage_client.dart';
import 'package:genesis/src/features/auth/data/source/access_token_dao.dart';

final class AccessTokenDao implements IAccessTokenDao {
  AccessTokenDao(this._client);

  static const _accessTokenKey = 'access_token';

  final ISecureStorageClient _client;

  @override
  Future<void> writeToken(String token) async {
    await _client.write(key: _accessTokenKey, value: token);
  }

  @override
  Future<void> deleteToken(String key) async {
    await _client.delete(_accessTokenKey);
  }

  @override
  Future<String?> getToken(String key) async {
    await _client.read(_accessTokenKey);
  }
}
