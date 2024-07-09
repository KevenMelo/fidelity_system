import 'package:eatagain/app/commons/blocs/sidebar/sidebar_cubit.dart';
import 'package:eatagain/app/commons/infra/repositories/tomtom_repository.dart';
import 'package:eatagain/app/commons/splash/splash_module.dart';
import 'package:eatagain/app/commons/utils/map_client.dart';
import 'package:eatagain/app/core/onboarding/onboarding_module.dart';
import 'package:eatagain/app/core/onboarding/onboarding_routes.dart';
import 'package:eatagain/app/core/orders/orders_module.dart';
import 'package:eatagain/app/core/orders/orders_routes.dart';
import 'package:eatagain/app/core/payment_methods/payment_methods_module.dart';
import 'package:eatagain/app/core/payment_methods/payment_methods_routes.dart';
import 'package:eatagain/app/core/restaurant_menu/constants/restaurant_menu_routes.dart';
import 'package:eatagain/app/core/restaurant_menu/restaurant_menu_module.dart';
import 'package:eatagain/app/core/restaurant_settings/constants/restaurant_settings_routes.dart';
import 'package:eatagain/app/core/restaurant_settings/restaurant_settings_module.dart';
import 'package:eatagain/app/core/restaurants/restaurant_module.dart';
import 'package:eatagain/app/core/restaurants/restaurant_routes.dart';
import 'package:eatagain/app/core/working_days/working_days_module.dart';
import 'package:eatagain/app/core/working_days/working_days_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'commons/auth/auth_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<SidebarCubit>(SidebarCubit.new);
    i.addLazySingleton<MapClient>(TomTomRepository.new);
  }

  @override
  void routes(r) {
    r.module('/', module: SplashModule());
    r.module('/auth', module: AuthModule());
    r.module(RestaurantRoutes.prefix, module: RestaurantModule());
    r.module(OnboardingRoutes.prefix, module: OnboardingModule());
    r.module(OrdersRoutes.prefix, module: OrdersModule());
    r.module(RestaurantMenuRoutes.prefix, module: RestaurantMenuModule());
    r.module(WorkingDaysRoutes.prefix, module: WorkingDaysModule());
    r.module(PaymentMethodsRoutes.prefix, module: PaymentMethodsModule());
    r.module(RestaurantSettingsRoutes.prefix,
        module: RestaurantSettingsModule());
  }
}
