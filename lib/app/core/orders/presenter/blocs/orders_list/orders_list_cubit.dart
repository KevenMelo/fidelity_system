import 'package:eatagain/app/core/orders/infra/models/order_model.dart';
import 'package:eatagain/app/core/orders/infra/repositories/orders_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_list_state.dart';

class OrdersListCubit extends Cubit<OrdersListState> {
  final OrdersRepository _repository = OrdersRepository();
  OrdersListCubit() : super(OrdersListState());

  Future<void> getOrders() async {
    emit(state.copyWith(isLoading: true));
    var response = await _repository.findAll(day: state.day);
    List<OrderModel> orders = [];
    if (response.ok) {
      orders = (response.result as List)
          .map((order) => OrderModel.fromJson(order))
          .toList();
    }
    emit(state.copyWith(orders: orders, isLoading: false));
  }
}
