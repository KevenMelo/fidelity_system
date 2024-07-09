part of 'products_list_cubit.dart';

class ProductsListState {
  DateTime day;
  bool isLoading;
  List<ProductModel> products;
  ProductsListState(
      {DateTime? day, this.isLoading = false, List<ProductModel>? products})
      : day = day ?? DateTime.now(),
        products = products ?? [];

  ProductsListState copyWith(
      {bool? isLoading, DateTime? day, List<ProductModel>? products}) {
    return ProductsListState(
        products: products ?? this.products,
        day: day ?? this.day,
        isLoading: isLoading ?? this.isLoading);
  }
}
