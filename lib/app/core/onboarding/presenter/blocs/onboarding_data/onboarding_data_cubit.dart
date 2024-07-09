import 'package:eatagain/app/core/restaurants/infra/models/restaurant_model.dart';
import 'package:eatagain/app/core/restaurants/infra/repositories/restaurant_repository.dart';
import 'package:eatagain/app/commons/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:melo_ui/melo_ui.dart';
part 'onboarding_data_state.dart';

class OnboardingDataCubit extends Cubit<OnboardingDataState> {
  final RestaurantRepository _repository;
  final ImagePicker _picker = ImagePicker();

  OnboardingDataCubit(this._repository) : super(OnboardingDataState());

  void setRestaurantData(RestaurantModel restaurant) {
    state.documentController.text = AppUtils.formatCNPJ(restaurant.cnpj);
    state.phoneController.text =
        restaurant.phone == null ? "" : AppUtils.formatPhone(restaurant.phone!);
    state.nameController.text = restaurant.name;
    state.restaurantId = restaurant.id;
    emit(state.copyWith());
  }

  Future<void> pickImage() async {
    XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    emit(state.copyWith(image: file));
  }

  Future<RestaurantModel?> save() async {
    List<MeloUIHttpErrorFieldModel> errors = [];
    String name = state.nameController.text;
    String document = AppUtils.removeCaracteres(state.documentController.text);
    String phone = AppUtils.removeCaracteres(state.phoneController.text);
    if (name.isEmpty) {
      errors.add(MeloUIHttpErrorFieldModel(
          key: 'name', errors: ['Nome é uma informação obrigatória']));
    }
    if (document.isEmpty) {
      errors.add(MeloUIHttpErrorFieldModel(
          key: 'document', errors: ['CNPJ é uma informação obrigatória']));
    } else if (!AppUtils.isValidCNPJ(state.documentController.text)) {
      errors.add(MeloUIHttpErrorFieldModel(
          key: 'document', errors: ['CNPJ informado é inválido']));
    }
    if (phone.isNotEmpty && !AppUtils.isValidPhone(phone)) {
      errors.add(MeloUIHttpErrorFieldModel(
          key: 'phone', errors: ['Telefone informado é inválido']));
    }
    if (errors.isNotEmpty) {
      emit(state.copyWith(errors: errors, isBusy: false));
      return null;
    }
    emit(state.copyWith(isBusy: true));

    var response = state.restaurantId != null
        ? await _repository.updateData(state.restaurantId!,
            name: name, document: document, phone: phone)
        : await _repository.create(
            name: name, document: document, phone: phone);
    if (response.data != null) {
      return response.data;
    } else if (response.error!.isNotEmpty) {
      if (response.error!.contains('phone')) {
        errors.add(
            MeloUIHttpErrorFieldModel(key: 'phone', errors: [response.error!]));
      }
      if (response.error!.contains('cnpj')) {
        errors.add(MeloUIHttpErrorFieldModel(
            key: 'document', errors: [response.error!]));
      }
      if (errors.isNotEmpty) {
        emit(state.copyWith(errors: errors, isBusy: false));
        return null;
      }
    }

    return null;
  }
}
