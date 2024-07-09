import 'package:eatagain/app/core/restaurant_menu/constants/restaurant_menu_routes.dart';
import 'package:eatagain/app/core/restaurant_menu/infra/models/category_model.dart';
import 'package:eatagain/app/core/restaurant_menu/infra/repositories/categories_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'categories_list_state.dart';

class CategoriesListCubit extends Cubit<CategoriesListState> {
  final CategoriesRepository _repository;
  CategoriesListCubit(this._repository) : super(CategoriesListState());

  void handleClickGoToForm({String? id}) {
    Modular.to.pushNamedAndRemoveUntil(
      RestaurantMenuRoutes.categoriesForm.complete,
      (p0) => false,
    );
  }

  Future<void> getCategories() async {
    emit(state.copyWith(isLoading: true));
    var response = await _repository.findAll();
    emit(state.copyWith(categories: response.data, isLoading: false));
  }

  Future<void> handleClickDeleteCategory(int id) async {
    emit(state.copyWith(deleteCat: (id: id, isLoadingDel: true)));
    var response = await _repository.deleteCategory(id);
    emit(state.copyWith(deleteCat: null));
    if (response == null) {
      getCategories();
      return;
    }
    emit(state.copyWith(error: response));
  }

  void getTabController(TickerProvider vsync) {
    emit(state.copyWith(
        tabController: state.tabController ?? _createTabController(vsync)));
  }

  TabController _createTabController(TickerProvider vsync) {
    return TabController(
      length: state.categories.length,
      vsync: vsync,
    );
  }
}
