import 'package:kronos/app/core/interface/ilocal_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService implements ILocalStorageService {
  @override
  Future<bool> setString(String key, String value) async {
    var instance = await SharedPreferences.getInstance();
    return instance.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    var instance = await SharedPreferences.getInstance();
    return instance.getString(key);
  }

  @override
  Future<bool> remove(String key) async {
    var instance = await SharedPreferences.getInstance();
    return instance.remove(key);
  }
}
