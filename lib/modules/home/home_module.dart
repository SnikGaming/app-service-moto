import 'package:app/modules/home/layouts/home_screen.dart';
import 'package:app/modules/home/routes/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(HomeRoute.index, child: (_, args) => const HomeScreen()),
      ];
}
