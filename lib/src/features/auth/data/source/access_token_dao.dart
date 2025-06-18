abstract interface class IAccessTokenDao {
  Future<void> writeToken(String token);

  Future<String?> getToken(String key);

  Future<void> deleteToken(String key);
}
