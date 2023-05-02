import 'package:app/modules/profile/routes/routest.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'layouts/profile_screen.dart';

class ProfileModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(ProfileRoute.index, child: (_, args) => const ProfileScreen()),
      ];
}
