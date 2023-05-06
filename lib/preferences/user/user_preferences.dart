import 'package:shared_preferences/shared_preferences.dart';

class UserPrefer {
  static const _email = "username";

  static const __imageUser = 'pic';
  static const __id = 'id';

  static const __gioitinh = 'gioitinh';

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

  //!: Get Username
  static Future setUserName({required String value}) async =>
      await preferences!.setString(_setUserName, value);
  static getsetUserName() => preferences!.getString(_setUserName);
  static Future removesetUserName() async =>
      await preferences!.remove(_setUserName);

  //!:
  static Future setToken({required String value}) async =>
      await preferences!.setString(_data, value);
  static getToken() => preferences!.getString(_data);
  static Future removesetToken() async => await preferences!.remove(_data);
//!: id
  static Future setId({required int value}) async =>
      await preferences!.setInt(__id, value);
  static getId() => preferences!.getInt(__id);
  static Future removeId() async => await preferences!.remove(__id);

  //!: gioi tinh
  static Future setGioiTinh({required String value}) async =>
      await preferences!.setString(__gioitinh, value);
  static getGioiTinh() => preferences!.getString(__gioitinh);
  static Future removeGioiTinh() async => await preferences!.remove(__gioitinh);
}
