abstract interface class ISecureStorageClient {
  Future<void> writeSecure({required String key, required String value});

  Future<String?> readSecure(String key);

  Future<void> deleteSecure(String key);
}
