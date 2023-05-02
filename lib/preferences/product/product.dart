import 'package:shared_preferences/shared_preferences.dart';

class ProductPrefer {
  // ignore: constant_identifier_names
  static const _total = "total";

  static SharedPreferences? preferences;
  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  // //! Total
  static Future setTotal({required int value}) async =>
      await preferences!.setInt(_total, value);
  static getTotal() => preferences!.getInt(_total);
  static Future removeTotal() async => await preferences!.remove(_total);
}
