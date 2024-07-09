import 'package:eatagain/app/commons/infra/models/address_model.dart';
import 'package:eatagain/app/core/onboarding/onboarding_routes.dart';
import 'package:eatagain/app/core/restaurants/infra/models/restaurant_model.dart';
import 'package:eatagain/app/commons/utils/app_utils.dart';
import 'package:eatagain/app/core/restaurants/infra/repositories/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../commons/widgets/step_progress_v2.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final RestaurantRepository _repository;
  OnboardingCubit(this._repository) : super(OnboardingState());

  set activeAddress(AddressModel? address) =>
      emit(state.copyWith(activeAddress: address));

  Future<void> initialize() async {
    if (state.restaurant != null) return;
    emit(state.copyWith(isLoading: true));
    RestaurantModel? restaurant;
    String? restaurantId = await AppUtils.getLocal('restaurant_id');
    if (restaurantId == null) return;
    if (state.restaurant != null && state.restaurant?.id == restaurantId) {
      restaurant = state.restaurant;
    } else {
      var response = await _repository.findById(restaurantId);
      if (response.data != null) {
        restaurant = response.data;
      } else {
        emit(state.copyWith(failedError: response.error, isLoading: false));
        return;
      }
    }

    emit(state.copyWith(
        currentStep: 0, restaurant: restaurant, isLoading: false));
  }

  void prevPage() {
    state.pageViewController.previousPage(
        duration: const Duration(seconds: 1), curve: Curves.easeOut);
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void nextPage() {
    state.pageViewController.animateToPage(state.currentStep + 1,
        duration: const Duration(seconds: 1), curve: Curves.easeOut);
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  void saveRestaurant(RestaurantModel? restaurant) {
    if (restaurant == null) return;
    state.copyWith(restaurant: restaurant);
    Modular.to.navigate(OnboardingRoutes.address.complete);
  }

  void goNextAddress(AddressModel? address) {
    if (address == null) return;
    emit(state.copyWith(activeAddress: address));
    nextPage();
  }

  void goNextConfirmAddress(RestaurantModel? restaurant) {
    if (restaurant == null) return;
    state.copyWith(restaurant: restaurant);
    nextPage();
  }
}
