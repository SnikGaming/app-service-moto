import 'package:app/preferences/settings/setting_prefer.dart';

import '../../preferences/user/user_preferences.dart';

class LogoutApp {
  // ignore: non_constant_identifier_names
  static void Logout() async {
    await UserPrefer.removeEmail();
    await UserPrefer.removeImageUser();
    await UserPrefer.removesetUserName();
    await UserPrefer.removesetToken();

    //!: Setting

    await SettingPrefer.removeLightDark();
  }
}
