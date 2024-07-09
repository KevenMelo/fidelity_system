import 'package:brasil_fields/brasil_fields.dart';
import 'package:eatagain/app/commons/constants/local_save_keys.dart';
import 'package:eatagain/app/commons/infra/models/address_model.dart';
import 'package:eatagain/app/commons/utils/app_utils.dart';
import 'package:eatagain/app/core/restaurants/infra/repositories/restaurant_repository.dart';
import 'package:eatagain/app/core/restaurants/restaurant_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:latlong2/latlong.dart';

part 'restaurant_settings_state.dart';

class RestaurantSettingsCubit extends Cubit<RestaurantSettingsState> {
  final RestaurantRepository _repository;
  RestaurantSettingsCubit(this._repository) : super(RestaurantSettingsState());

  set activeDistanceDelivery(int? value) =>
      emit(state.copyWith(activeDistanceDelivery: value));

  void handleChangeAddress(AddressModel address) {
    state.mapAddressController
        .move(LatLng(address.latitude, address.longitude), 15);
    state.mapDeliveryController
        .move(LatLng(address.latitude, address.longitude), 12);

    emit(state.copyWith(activeAddress: address));
  }

  Future<void> getRestaurantById() async {
    emit(state.copyWith(isLoading: true));
    var restaurantId = await AppUtils.getLocal(LocalSaveKeys.restaurantId);
    if (restaurantId == null) {
      Modular.to.pushNamedAndRemoveUntil(
          RestaurantRoutes.root.complete, (p0) => false);
      return;
    }
    var response = await _repository.findById(restaurantId);
    AddressModel? address;
    if (response.data != null) {
      state.cnpjController.text =
          UtilBrasilFields.obterCnpj(response.data!.cnpj);
      state.nameController.text = response.data!.name;
      state.phoneController.text = response.data!.phone == null
          ? ""
          : UtilBrasilFields.obterTelefone(response.data!.phone!);
      state.distanceDeliveryController.text =
          (response.data!.distanceDelivery ?? "").toString();
      state.distancePriceController.text =
          UtilBrasilFields.obterReal(response.data?.distancePrice ?? 0);
      state.distanceStartController.text =
          (response.data!.distanceStart ?? "").toString();
      if (response.data!.street != null &&
          response.data!.lat != null &&
          response.data!.lng != null) {
        address = AddressModel(
            street: response.data!.street!,
            neighborhood: response.data!.district!,
            postalCode: response.data!.zipCode!,
            latitude: response.data!.lat!,
            longitude: response.data!.lng!,
            city: response.data!.city!,
            state: response.data!.estate!);
        state.complementController.text = response.data!.complement ?? "";
        state.referenceController.text = response.data!.referencePoint ?? "";
        state.numberController.text = response.data!.number ?? "";
      }
    }
    emit(state.copyWith(
      isLoading: false,
      activeDistanceDelivery: response.data?.distanceDelivery,
      restaurantId: restaurantId,
      failedError: response.error,
      activeAddress: address,
    ));
  }

  Future<void> save() async {
    emit(state.copyWith(isBusy: true));
    var response = await _repository.updateData(state.restaurantId!,
        document: UtilBrasilFields.removeCaracteres(state.cnpjController.text),
        name: state.nameController.text,
        phone: UtilBrasilFields.removeCaracteres(state.phoneController.text));
    emit(state.copyWith(
      isBusy: false,
      failedError: response.error,
    ));
  }

  Future<void> saveDeliverySettings() async {
    emit(state.copyWith(isBusy: true));
    var response = await _repository.updateSettingsDistance(state.restaurantId!,
        distance: int.parse(state.distanceDeliveryController.text),
        price: UtilBrasilFields.converterMoedaParaDouble(
            state.distancePriceController.text),
        startIn: int.parse(state.distanceStartController.text));
    emit(state.copyWith(
      isBusy: false,
      failedError: response.error,
    ));
  }

  Future<void> saveAddress() async {
    emit(state.copyWith(isBusy: true));
    state.activeAddress!.complement = state.complementController.text;
    state.activeAddress!.number = state.numberController.text;
    state.activeAddress!.referencePoint = state.referenceController.text;
    var response = await _repository.updateAddress(
        state.restaurantId!, state.activeAddress!);
    emit(state.copyWith(
      isBusy: false,
      failedError: response.error,
    ));
  }
}
