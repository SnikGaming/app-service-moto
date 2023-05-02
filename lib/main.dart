import 'package:app/modules/app_module.dart';
import 'package:app/preferences/product/product.dart';
import 'package:app/preferences/settings/setting_prefer.dart';
import 'package:app/preferences/user/user_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'modules/home/api/category/api_category.dart';
import 'modules/home/api/products/api_product.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await SettingPrefer.init();
  await ProductPrefer.init();
  await UserPrefer.init();
  await APIProduct.getData();
  await APICategory.getData();
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
  // runApp(DevicePreview(
  //     // enabled: kIsWeb,
  //     builder: ((context) =>
  //         ModularApp(module: AppModule(), child: const MyApp()))));
}
