// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class CompanyPrefer {
  static const _name_company = "name_company";
  static SharedPreferences? preferences;
  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  // //! Company
  static Future setNameCompany({required String value}) async =>
      await preferences!.setString(_name_company, value);
  static getNameCompany() => preferences!.getString(_name_company);
  static Future removeNameCompany() async =>
      await preferences!.remove(_name_company);
}
