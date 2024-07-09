import 'package:eatagain/app/core/restaurant_menu/constants/restaurant_menu_routes.dart';
import 'package:eatagain/app/core/restaurant_menu/infra/extensions/complement_type_extension.dart';
import 'package:eatagain/app/core/restaurant_menu/infra/models/category_complement_model.dart';
import 'package:eatagain/app/core/restaurant_menu/infra/models/category_model.dart';
import 'package:eatagain/app/core/restaurant_menu/infra/repositories/categories_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

import '../../../infra/models/complement_type.dart';

part 'categories_form_state.dart';

class CategoriesFormCubit extends Cubit<CategoriesFormState> {
  final CategoriesRepository _repository;
  CategoriesFormCubit(this._repository) : super(CategoriesFormState());

  void handleClickNavigateBack() {
    if (Modular.to.canPop()) {
      Modular.to.pop();
    } else {
      Modular.to
          .pushReplacementNamed(RestaurantMenuRoutes.categoriesList.complete);
    }
  }

  void handleReorderComplements(int oldIndex, int newIndex) {
    var complements = state.complements;
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    CategoryComplementModel item = complements.removeAt(oldIndex);
    complements.insert(newIndex, item);
    emit(state.copyWith(complements: complements));
  }

  void handleSelectComplementType(ComplementType? value) {
    if (value == null) return;
    state.pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.linear);

    emit(state.copyWith(
        complementType: value,
        complements:
            value == state.complementType ? null : value.getComplements()));
  }

  void unSelectComplementType() {
    state.pageController.previousPage(
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void handleClickDeleteComplement(int index) {
    var complements = state.complements;
    complements.removeAt(index);
    emit(state.copyWith(complements: complements));
  }

  void handleClickAddComplement() {
    var complements = state.complements;

    int index = complements.indexWhere(
        (element) => element.name == state.nameComplementController.text);
    if (index == -1 && state.nameComplementController.text.isNotEmpty) {
      complements.add(CategoryComplementModel(
          id: null, name: state.nameComplementController.text));
      state.nameComplementController.clear();
    }

    emit(state.copyWith(complements: complements));
  }

  Future<void> getCategoryById(String? id) async {
    if (id == null) {
      state.nameComplementController.clear();
      state.nameController.clear();
      emit(state.copyWith(complements: []));
    }
    return;
    emit(state.copyWith(isLoading: true));
    var response = await _repository.findAll();
    emit(state.copyWith(isLoading: false));
  }

  Future<void> save() async {
    if (state.nameController.text.isEmpty) {
      emit(state.copyWith(errors: [
        MeloUIHttpErrorFieldModel(
            key: 'name', errors: ['Nome é uma informação obrigatória'])
      ]));
      return;
    }
    emit(state.copyWith(isBusy: true));
    var response = await _repository.create(CategoryModel(
        id: null,
        name: state.nameController.text,
        complements: state.complements));
    emit(state.copyWith(isBusy: false, error: response.error));
    if (response.data != null) {
      handleClickNavigateBack();
    } else {
      emit(state.copyWith(errors: [
        MeloUIHttpErrorFieldModel(
            key: 'http', errors: [response.error ?? 'Erro desconhecido'])
      ]));
    }
  }
}
