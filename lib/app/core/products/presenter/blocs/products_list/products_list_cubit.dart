import 'package:eatagain/app/core/products/infra/models/product_model.dart';
import 'package:eatagain/app/core/products/infra/repositories/products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_list_state.dart';

class ProductsListCubit extends Cubit<ProductsListState> {
  final ProductsRepository _repository = ProductsRepository();
  ProductsListCubit() : super(ProductsListState());

  Future<void> getProducts() async {
    emit(state.copyWith(isLoading: true));
    var response = await _repository.findAll(day: state.day);
    List<ProductModel> products = [];
    if (response.ok) {
      products = (response.result as List)
          .map((order) => ProductModel.fromJson(order))
          .toList();
    }
    emit(state.copyWith(products: products, isLoading: false));
  }
}
