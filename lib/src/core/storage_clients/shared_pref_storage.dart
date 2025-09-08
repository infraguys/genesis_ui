import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
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
    return prefs.getString(key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    final res = await prefs.setString(key, value);
    print(res);
  }
}
