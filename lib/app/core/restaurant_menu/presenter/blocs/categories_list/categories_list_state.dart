part of 'categories_list_cubit.dart';

class CategoriesListState {
  bool isLoading;
  List<CategoryModel> categories;
  ({bool isLoadingDel, int id})? deleteCat;
  String? error;
  TabController? tabController;
  CategoriesListState(
      {this.isLoading = false,
      List<CategoryModel>? categories,
      this.error,
      this.deleteCat,
      this.tabController})
      : categories = categories ?? [];

  CategoriesListState copyWith(
      {bool? isLoading,
      List<CategoryModel>? categories,
      TabController? tabController,
      String? error,
      ({bool isLoadingDel, int id})? deleteCat}) {
    return CategoriesListState(
        tabController: tabController ?? this.tabController,
        categories: categories ?? this.categories,
        deleteCat: deleteCat ?? this.deleteCat,
        error: error,
        isLoading: isLoading ?? this.isLoading);
  }
}
