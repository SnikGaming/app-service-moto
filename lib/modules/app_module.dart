import 'package:app/modules/details/details_module.dart';
import 'package:app/modules/flash/flash_module.dart';
import 'package:app/modules/home/home_module.dart';
import 'package:app/modules/profile/profile_module.dart';
import 'package:app/modules/register/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_constants.dart';
import 'login/login_module.dart';
import 'notifile/notifica_module.dart';

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
      ];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //    localizationsDelegates: [
      //   // ... app-specific localization delegate[s] here
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   DefaultCupertinoLocalizations.delegate,
      // ],
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('de', 'DE'), // German
        // ... other locales the app supports
      ],
      debugShowCheckedModeBanner: false,
      // title: 'My Smart App',
      theme: ThemeData(
        brightness: Brightness.light,
        // brightness: Brightness.light,
        useMaterial3: true,
        // primaryColor: Colors.lightBlue[800],
        // primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Sono'),
        ),
      ),

      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
