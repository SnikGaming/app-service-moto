import 'package:flutter_modular/flutter_modular.dart';

import 'layouts/order_screen.dart';

class OrderModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, args) => const OrderScreen()),
      ];
}
