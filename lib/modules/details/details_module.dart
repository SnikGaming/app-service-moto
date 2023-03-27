import 'package:app/modules/details/layouts/detail_product.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'layouts/detail_service.dart';

class DetailsModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (_, args) => DetailsServiceScreen(data: args.data)),
        ChildRoute('/product',
            child: (_, args) => DetailProductScreen(data: args.data)),
      ];
}
