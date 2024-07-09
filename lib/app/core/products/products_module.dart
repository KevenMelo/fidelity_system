import 'package:eatagain/app/core/products/presenter/blocs/products_list/products_list_cubit.dart';
import 'package:eatagain/app/core/products/presenter/pages/products_form_web_page.dart';
import 'package:eatagain/app/core/products/presenter/pages/products_list_web_page.dart';
import 'package:eatagain/app/core/products/products_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductsModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<ProductsListCubit>(ProductsListCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      ProductsRoutes.root.path,
      child: (context) => const ProductsListWebPage(),
    );
    r.child(
      ProductsRoutes.create.path,
      child: (context) => const ProductsFormWebPage(),
    );
  }
}
