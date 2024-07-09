import 'package:eatagain/app/core/orders/orders_routes.dart';
import 'package:eatagain/app/core/orders/presenter/blocs/orders_list/orders_list_cubit.dart';
import 'package:eatagain/app/core/orders/presenter/pages/orders_list_web_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrdersModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<OrdersListCubit>(OrdersListCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      OrdersRoutes.root.path,
      child: (context) => const OrdersListWebPage(),
    );
  }
}
