import 'package:app/modules/register/layouts/register_screen.dart';
import 'package:app/modules/register/routes/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(RegisterRoute.index,
            child: (_, args) => const RegisterScreeen()),
      ];
}
