import 'package:genesis/src/core/interfaces/i_base_storage_client.dart';
import 'package:logging/logging.dart';

final log = Logger('TokenDaoLogger');

final class TokenDao {
  TokenDao(this._client);

  final IBaseStorageClient _client;

  static const _tokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> deleteToken() async {
    await _client.delete(_tokenKey);
  }

  Future<String?> readToken() async {
    return await _client.read(_tokenKey);
  }

  Future<void> writeToken(String value) async {
    log.info('TokenDao/write token: value: $value');
    await _client.write(key: _tokenKey, value: value);
  }

  // Refresh token   ----------

  Future<void> writeRefreshToken(String value) async {
    log.info('TokenDao/write refreshToken: value: $value');
    await _client.write(key: _refreshTokenKey, value: value);
  }

  Future<void> deleteRefreshToken() async {
    await _client.delete(_refreshTokenKey);
  }

  Future<String?> readRefreshToken() async {
    return await _client.read(_refreshTokenKey);
  }
}
