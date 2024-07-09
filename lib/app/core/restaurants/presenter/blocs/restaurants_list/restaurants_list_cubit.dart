import 'package:eatagain/app/commons/constants/local_save_keys.dart';
import 'package:eatagain/app/core/onboarding/onboarding_routes.dart';
import 'package:eatagain/app/core/orders/orders_routes.dart';
import 'package:eatagain/app/core/restaurants/infra/models/restaurant_model.dart';
import 'package:eatagain/app/commons/utils/app_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../infra/repositories/restaurant_repository.dart';

part 'restaurants_list_state.dart';

class RestaurantsListCubit extends Cubit<RestaurantsListState> {
  final RestaurantRepository _repository;
  RestaurantsListCubit(this._repository) : super(RestaurantsListState());

  Future<void> getRestaurants() async {
    String? restaurantId = await AppUtils.getLocal(LocalSaveKeys.restaurantId);
    emit(state.copyWith(isLoading: true));
    var response = await _repository.findAll();
    if (response.data != null) {
      if (response.data!.isEmpty) {
        Modular.to.pushNamedAndRemoveUntil(
            OnboardingRoutes.root.complete, (p0) => false);
      }
      emit(state.copyWith(
        isLoading: false,
        restaurants: response.data!,
      ));

      if (restaurantId != null) {
        int index =
            response.data!.indexWhere((element) => element.id == restaurantId);
        if (index > -1 &&
            _isRegisterCompleteByRestaurant(response.data![index])) {
          selectRestaurant(response.data![index]);
          return;
        }
      }
    } else {
      emit(state.copyWith(isLoading: false, failedError: response.error));
    }
  }

  bool _isRegisterCompleteByRestaurant(RestaurantModel restaurant) {
    if (restaurant.lat == null || restaurant.lng == null) return false;

    return true;
  }

  Future<void> selectRestaurant(RestaurantModel restaurant) async {
    await AppUtils.saveLocal(LocalSaveKeys.restaurantId, restaurant.id);
    if (restaurant.lat == null || restaurant.lng == null) {
      Modular.to.navigate(OnboardingRoutes.address.complete);
      return;
    }

    Modular.to.navigate(OrdersRoutes.root.complete);
    return;
  }
}
