import 'package:empreiteiraApp/interfaces/app_config_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService implements IAppConfigService {
  @override
  Future delete(String key) async {
    var shared = await SharedPreferences.getInstance();
    return shared.remove(key);
  }

  @override
  Future get(String key) async {
    var shared = await SharedPreferences.getInstance();
    return shared.get(key);
  }

  @override
  Future put(String key, value) async {
    var shared = await SharedPreferences.getInstance();
    if (value is bool) return shared.setBool(key, value);
    if (value is String) return shared.setString(key, value);
    if (value is double) return shared.setDouble(key, value);
    if (value is int) return shared.setInt(key, value);
    if (value is List<String>) return shared.setStringList(key, value);
  }

}