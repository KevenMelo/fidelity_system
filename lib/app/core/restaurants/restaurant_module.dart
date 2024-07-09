import 'package:eatagain/app/core/restaurants/infra/repositories/restaurant_repository.dart';
import 'package:eatagain/app/core/restaurants/presenter/blocs/restaurants_list/restaurants_list_cubit.dart';
import 'package:eatagain/app/core/restaurants/presenter/pages/restaurants_list_web_page.dart';
import 'package:eatagain/app/core/restaurants/restaurant_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RestaurantModule extends Module {
  @override
  void binds(i) {
    i.add<RestaurantRepository>(RestaurantRepositoryImplementation.new);
    i.addLazySingleton<RestaurantsListCubit>(RestaurantsListCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      RestaurantRoutes.root.path,
      child: (context) => const RestaurantsListWebPage(),
    );
  }
}
