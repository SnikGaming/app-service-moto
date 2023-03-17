import 'package:app/modules/login/layouts/login_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, args) => const LoginScreen()),
      ];
}
