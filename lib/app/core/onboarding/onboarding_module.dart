import 'package:eatagain/app/core/onboarding/onboarding_routes.dart';
import 'package:eatagain/app/core/onboarding/presenter/blocs/onboarding/onboarding_cubit.dart';
import 'package:eatagain/app/core/onboarding/presenter/blocs/onboarding_address/onboarding_address_cubit.dart';
import 'package:eatagain/app/core/onboarding/presenter/blocs/onboarding_data/onboarding_data_cubit.dart';
import 'package:eatagain/app/core/onboarding/presenter/blocs/onboarding_delivery/onboarding_delivery_cubit.dart';
import 'package:eatagain/app/core/onboarding/presenter/ui/pages/onboarding_address_web_page.dart';
import 'package:eatagain/app/core/onboarding/presenter/ui/pages/onboarding_confirm_address_web_page.dart';
import 'package:eatagain/app/core/onboarding/presenter/ui/pages/onboarding_data_web_page.dart';
import 'package:eatagain/app/core/onboarding/presenter/ui/pages/onboarding_delivery_web_page.dart';
import 'package:eatagain/app/core/restaurants/infra/repositories/restaurant_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OnboardingModule extends Module {
  @override
  void binds(i) {
    i.add<RestaurantRepository>(RestaurantRepositoryImplementation.new);
    i.addLazySingleton<OnboardingCubit>(OnboardingCubit.new);
    i.addLazySingleton<OnboardingDataCubit>(OnboardingDataCubit.new);
    i.addLazySingleton<OnboardingAddressCubit>(OnboardingAddressCubit.new);
    i.addLazySingleton<OnboardingDeliveryCubit>(OnboardingDeliveryCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      OnboardingRoutes.root.path,
      child: (context) => const OnboardingDataWebPage(),
    );
    r.child(
      OnboardingRoutes.address.path,
      child: (context) => const OnboardingAddressWebPage(),
    );
    r.child(
      OnboardingRoutes.confirmAddress.path,
      child: (context) => const OnboardingConfirmAddressWebPage(),
    );
    r.child(
      OnboardingRoutes.delivery.path,
      child: (context) => const OnboardingDeliveryWebPage(),
    );
  }
}
