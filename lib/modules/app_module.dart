import 'package:app/modules/details/details_module.dart';
import 'package:app/modules/flash/flash_module.dart';
import 'package:app/modules/home/home_module.dart';
import 'package:app/modules/profile/profile_module.dart';
import 'package:app/modules/register/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../components/calendar/res/colors.dart';
import 'app_constants.dart';
import 'login/login_module.dart';
import 'notifile/notifica_module.dart';
import 'order/order_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];
  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Routes.index, module: FlashModule()),
        ModuleRoute(Routes.home, module: HomeModule()),
        ModuleRoute(Routes.login, module: LoginModule()),
        ModuleRoute(Routes.register, module: RegisterModule()),
        ModuleRoute(Routes.details, module: DetailsModule()),
        ModuleRoute(Routes.profile, module: ProfileModule()),
        ModuleRoute(Routes.notifications, module: NotificationModule()),
        ModuleRoute(Routes.order, module: OrderModule()),
      ];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      //    localizationsDelegates: [
      //   // ... app-specific localization delegate[s] here
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   DefaultCupertinoLocalizations.delegate,
      // ],
      supportedLocales: const [
        const Locale('vi', 'VN'),
        Locale('en', 'US'), // English
        Locale('de', 'DE'), // German
      ],
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: violet),
        primaryColor: violet,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: violet),
        iconTheme: const IconThemeData(color: violet),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            textStyle: const TextStyle(
              color: violet,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            foregroundColor: violet,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            shadowColor: Colors.transparent,
            elevation: 0,
            foregroundColor: violet,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
        ),
        dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
      ),

      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
