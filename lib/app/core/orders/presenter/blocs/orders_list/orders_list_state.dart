part of 'orders_list_cubit.dart';

class OrdersListState {
  DateTime day;
  bool isLoading;
  List<OrderModel> orders;
  OrdersListState(
      {DateTime? day, this.isLoading = false, List<OrderModel>? orders})
      : day = day ?? DateTime.now(),
        orders = orders ?? [];

  OrdersListState copyWith(
      {bool? isLoading, DateTime? day, List<OrderModel>? orders}) {
    return OrdersListState(
        orders: orders ?? this.orders,
        day: day ?? this.day,
        isLoading: isLoading ?? this.isLoading);
  }
}
