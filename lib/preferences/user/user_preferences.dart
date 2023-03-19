import 'package:shared_preferences/shared_preferences.dart';

class UserPrefer {
  static const _email = "username";

  static const _listEmail = "listEmail";

  static const __imageUser = 'pic';

  static const _data = "token";

  static const _setUserName = "user_id";
  static SharedPreferences? preferences;
  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  // //! Login user
  static Future setEmail({required String value}) async =>
      await preferences!.setString(_email, value);
  static getEmail() => preferences!.getString(_email);
  static Future removeEmail() async => await preferences!.remove(_email);

  // //! Login user
  static Future setImageUser({required String value}) async =>
      await preferences!.setString(__imageUser, value);
  static getImageUser() => preferences!.getString(__imageUser);
  static Future removeImageUser() async =>
      await preferences!.remove(__imageUser);

  //!: Get ID User
  static Future setUserName({required String value}) async =>
      await preferences!.setString(_setUserName, value);
  static getsetUserName() => preferences!.getString(_setUserName);
  static Future removesetUserName() async =>
      await preferences!.remove(_setUserName);

  //!:Get all Email
  static Future setAllEmail({required List<String> value}) async =>
      await preferences!.setStringList(_listEmail, value);
  static getsetAllEmail() => preferences!.getStringList(_listEmail);
  static Future removesetAllEmail() async =>
      await preferences!.remove(_listEmail);

  //!:
  static Future setToken({required String value}) async =>
      await preferences!.setString(_data, value);
  static getToken() => preferences!.getString(_data);
  static Future removesetToken() async => await preferences!.remove(_data);
}
