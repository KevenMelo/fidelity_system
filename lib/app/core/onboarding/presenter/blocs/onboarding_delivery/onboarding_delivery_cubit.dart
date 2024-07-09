import 'package:eatagain/app/core/orders/orders_routes.dart';
import 'package:eatagain/app/core/restaurants/infra/models/restaurant_model.dart';
import 'package:eatagain/app/core/restaurants/infra/repositories/restaurant_repository.dart';
import 'package:eatagain/app/commons/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'onboarding_delivery_state.dart';

class OnboardingDeliveryCubit extends Cubit<OnboardingDeliveryState> {
  final RestaurantRepository _repository;

  OnboardingDeliveryCubit(this._repository) : super(OnboardingDeliveryState());

  set distanceDelivery(double? value) =>
      emit(state.copyWith(distanceDelivery: value));

  Future<RestaurantModel?> saveSettingsDistance(
    String restaurantId,
  ) async {
    emit(state.copyWith(isBusy: true));
    var response = await _repository.updateSettingsDistance(restaurantId,
        distance: state.distanceDelivery.toInt(),
        price: AppUtils.getCurrencyValueInDouble(
            state.distancePriceController.text),
        startIn: int.parse(state.distanceStartController.text));
    emit(state.copyWith(isBusy: false));
    if (response.data != null) {
      Modular.to.navigate(OrdersRoutes.root.complete);
    }
    return response.data;
  }
}
