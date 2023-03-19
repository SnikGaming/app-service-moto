import 'package:shared_preferences/shared_preferences.dart';

class UserPrefer {
  static const _email = "username";

  static const _listEmail = "listEmail";

  static const _data = "token";

  static const _setIdUser = "user_id";
  static SharedPreferences? preferences;
  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  // //! Login user
  static Future setEmail({required String value}) async =>
      await preferences!.setString(_email, value);
  static getEmail() => preferences!.getString(_email);
  static Future removeEmail() async => await preferences!.remove(_email);

  //!: Get ID User
  static Future setIdUser({required String value}) async =>
      await preferences!.setString(_setIdUser, value);
  static getsetIdUser() => preferences!.getString(_setIdUser);
  static Future removesetIdUser() async =>
      await preferences!.remove(_setIdUser);

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
