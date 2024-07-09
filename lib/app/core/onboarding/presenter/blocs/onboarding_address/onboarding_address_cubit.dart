import 'package:eatagain/app/commons/infra/models/address_model.dart';
import 'package:eatagain/app/core/onboarding/onboarding_routes.dart';
import 'package:eatagain/app/core/orders/orders_routes.dart';
import 'package:eatagain/app/core/restaurants/infra/repositories/restaurant_repository.dart';
import 'package:eatagain/app/core/restaurants/infra/models/restaurant_model.dart';
import 'package:eatagain/app/commons/utils/map_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';

part 'onboarding_address_state.dart';

class OnboardingAddressCubit extends Cubit<OnboardingAddressState> {
  final RestaurantRepository _repository;
  final MapClient _repositoryMap = Modular.get<MapClient>();

  OnboardingAddressCubit(this._repository) : super(OnboardingAddressState());

  Future<void> initialize() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();
    var address = await _repositoryMap.getAddressByGeopoint(
        latitude: position.latitude, longitude: position.longitude);
    emit(state.copyWith(location: address));
  }

  Future<void> save(String restaurantId) async {
    state.activeAddress!.complement = state.complementController.text;
    state.activeAddress!.number = state.numberController.text;
    state.activeAddress!.referencePoint = state.referenceController.text;
    emit(state.copyWith(isBusy: true));
    var response =
        await _repository.updateAddress(restaurantId, state.activeAddress!);
    emit(state.copyWith(isBusy: false, failedError: response.error));
    if (response.data != null) {
      Modular.to.navigate(OrdersRoutes.root.complete);
    }
  }

  void hasAddressToConfirm() {
    if (state.activeAddress == null) {
      if (Modular.to.canPop()) {
        Modular.to.pop();
      } else {
        Modular.to.navigate(OnboardingRoutes.address.complete);
      }
    }
  }

  void onChangeActiveAddress(AddressModel address) {
    emit(state.copyWith(activeAddress: address));
    Modular.to.navigate(OnboardingRoutes.confirmAddress.complete);
  }
}
