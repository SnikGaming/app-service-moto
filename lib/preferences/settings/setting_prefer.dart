import 'package:shared_preferences/shared_preferences.dart';

class SettingPrefer {
  static const _light_dark = "setting";

  static SharedPreferences? preferences;
  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  // //! Light
  static Future setLightDark({required bool value}) async =>
      await preferences!.setBool(_light_dark, value);
  static getLightDark() => preferences!.getBool(_light_dark);
  static Future removeLightDark() async =>
      await preferences!.remove(_light_dark);
}
