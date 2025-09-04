import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';

final class TokenDao {
  TokenDao(this._client);

  final SecureStorageClient _client;

  static const _tokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> deleteToken() async {
    await _client.delete(_tokenKey);
  }

  Future<String?> readToken() async {
    return await _client.read(_tokenKey);
  }

  Future<void> writeToken(String value) async {
    await _client.write(key: _tokenKey, value: value);
  }

  // Refresh token   ----------

  Future<void> writeRefreshToken(String value) async {
    await _client.write(key: _refreshTokenKey, value: value);
  }

  Future<void> deleteRefreshToken() async {
    await _client.delete(_refreshTokenKey);
  }

  Future<String?> readRefreshToken() async {
    return await _client.read(_refreshTokenKey);
  }
}
