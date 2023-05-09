import 'package:app/preferences/settings/setting_prefer.dart';

import '../../preferences/user/user_preferences.dart';

class LogoutApp {
  static Future<void> logout() async {
    await Future.wait([
      UserPrefer.removeEmail(),
      UserPrefer.removeImageUser(),
      UserPrefer.removesetUserName(),
      UserPrefer.removesetToken(),
      UserPrefer.removeId(),
      UserPrefer.removeGioiTinh(),
      SettingPrefer.removeLightDark(),
    ]);
  }
}
