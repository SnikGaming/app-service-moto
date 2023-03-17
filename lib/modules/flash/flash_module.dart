import 'package:app/modules/login/layouts/login_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'layouts/flash_screen.dart';

class FlashModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, args) => const FlashScreen()),
      ];
}
