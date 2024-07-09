import 'package:eatagain/app/core/restaurant_settings/presenter/blocs/restaurant_settings/restaurant_settings_cubit.dart';
import 'package:eatagain/app/core/restaurant_settings/presenter/pages/restaurant_settings_page.dart';
import 'package:eatagain/app/core/restaurants/infra/repositories/restaurant_repository.dart';
import 'package:eatagain/app/core/restaurants/restaurant_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RestaurantSettingsModule extends Module {
  @override
  void binds(i) {
    i.add<RestaurantRepository>(RestaurantRepositoryImplementation.new);
    i.addLazySingleton<RestaurantSettingsCubit>(RestaurantSettingsCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      RestaurantRoutes.root.path,
      child: (context) => const RestaurantSettingsPage(),
    );
  }
}
