import 'package:empreiteiraApp/interfaces/app_config_service.dart';
import 'package:empreiteiraApp/models/app_config_model.dart';
import 'package:empreiteiraApp/services/app_config_service/shared_preferences_service.dart';
import 'package:flutter/cupertino.dart';

class AppConfigProvider with ChangeNotifier {
  final IAppConfigService service = SharedPreferenceService();

  AppConfig _appConfig;
  AppConfig get appConfig => _appConfig;

  AppConfigProvider() {
    _appConfig = AppConfig();

    service.get('themeIsDark').then(
      (value) {
        if (value != null) {
          _appConfig.themeIsDark = value;
          notifyListeners();
        } else {
          _appConfig.themeIsDark = false;
          service.put('themeIsDark', false);
          notifyListeners();
        }
      },
    );
  }

  void changeTheme(bool value) {
    _appConfig.themeIsDark = value;
    service.put('themeIsDark', value);
    notifyListeners();
  }
}
