import 'package:genesis/src/core/interfaces/i_base_storage_client.dart';
import 'package:logging/logging.dart';

final class TokenDao {
  TokenDao(this._client);

  final _log = Logger('TokenDaoLogger');

  final IBaseStorageClient _client;

  static const _tokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> deleteToken() async {
    _log.info('Delete token');
    await _client.delete(_tokenKey);
  }

  Future<String?> readToken() async {
    _log.info('Read token');
    return await _client.read(_tokenKey);
  }

  Future<void> writeToken(String value) async {
    _log.info('Write token: $value');
    await _client.write(key: _tokenKey, value: value);
  }

  // Refresh token   ----------

  Future<void> writeRefreshToken(String value) async {
    _log.info('Write refreshToken: $value');
    await _client.write(key: _refreshTokenKey, value: value);
  }

  Future<void> deleteRefreshToken() async {
    _log.info('Delete refreshToken');
    await _client.delete(_refreshTokenKey);
  }

  Future<String?> readRefreshToken() async {
    return await _client.read(_refreshTokenKey);
  }
}
