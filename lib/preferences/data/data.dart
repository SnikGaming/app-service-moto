import 'package:shared_preferences/shared_preferences.dart';

class DataPrefer {
  static final _listProduct = 'listProduct';

  static SharedPreferences? preferences;
  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  //!: Product
  static Future setDataProduct({required List<String> value}) async =>
      await preferences!.setStringList(_listProduct, value);
  static getDataProduct() => preferences!.getStringList(_listProduct);
  static Future removeDataProduct() async =>
      await preferences!.remove(_listProduct);
}
