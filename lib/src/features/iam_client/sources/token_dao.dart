import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';

final class TokenDao {
  TokenDao(this._client);

  final ISecureStorageClient _client;

  static const _tokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> deleteToken() async {
    await _client.deleteSecure(_tokenKey);
  }

  Future<String?> readToken() async {
    return await _client.readSecure(_tokenKey);
  }

  Future<void> writeToken(String value) async {
    await _client.writeSecure(key: _tokenKey, value: value);
  }

  // Refresh token   ----------

  Future<void> writeRefreshToken(String value) async {
    await _client.writeSecure(key: _refreshTokenKey, value: value);
  }

  Future<void> deleteRefreshToken() async {
    await _client.deleteSecure(_refreshTokenKey);
  }

  Future<String?> readRefreshToken() async {
    return await _client.readSecure(_refreshTokenKey);
  }
}
