import 'package:genesis/src/core/secure_storage_client/i_simple_storage_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedPrefStorage implements ISimpleStorageClient {
  @override
  Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  @override
  Future<String?> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.get(key);
    return null;
  }

  @override
  Future<void> write({required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
