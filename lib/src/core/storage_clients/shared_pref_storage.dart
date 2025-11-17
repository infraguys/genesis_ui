import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedPrefStorage implements ISimpleStorageClient {
  SharedPrefStorage._(this._prefs);

  final SharedPreferences _prefs;

  static Future<SharedPrefStorage> init() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefStorage._(prefs);
  }

  @override
  Future<void> delete(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<String?> read(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await _prefs.setString(key, value);
  }
}
