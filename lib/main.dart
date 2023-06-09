import 'package:app/modules/app_module.dart';
import 'package:app/modules/home/api/login/api_login.dart';
import 'package:app/preferences/product/product.dart';
import 'package:app/preferences/settings/setting_prefer.dart';
import 'package:app/preferences/user/user_preferences.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'modules/home/api/banner/api_banner.dart';
import 'modules/home/api/booking/api_booking.dart';
import 'modules/home/api/favorites/api.dart';
import 'modules/home/api/location/api_location.dart';
import 'modules/home/api/payment/api_payment.dart';

Future<void> main(List<String> args) async {
  Stripe.publishableKey =
      'pk_test_51NGFj9Kl8H5lkAhSTO7jGUiuz6bp4LETENvHSBEqRwm5zGNPKxDsunHj7v0CiUleIY8Fa4vg4fefV0ZfQqbqNktf00DLp5lLTX';
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
  // await APICategory.getData();
  await APIBanner.getData();
  // await APIProduct.getData();
  if (UserPrefer.getToken() != null && UserPrefer.getToken() != 'null') {
    await APIBooking.fetchBookings();
    await APIAuth.getUser();
    await APIFavorites.getData();
    // await APIOrder.fetchOrder();
  } 
  await APIPaymentMethod.fetchPayment();
  await APILocation.fetchLocation();
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
  // runApp(DevicePreview(
  //     // enabled: kIsWeb,
  //     builder: ((context) =>
  //         ModularApp(module: AppModule(), child: const MyApp()))));
}
