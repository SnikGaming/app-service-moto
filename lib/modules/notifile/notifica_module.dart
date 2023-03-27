import 'package:app/modules/notifile/routes/routest.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'layouts/notification_screen.dart';

class NotificationModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(NotificaRoute.index,
            child: (_, args) => const NotificationScreen()),
      ];
}
