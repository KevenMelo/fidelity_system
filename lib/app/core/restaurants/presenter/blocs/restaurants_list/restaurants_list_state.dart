part of 'restaurants_list_cubit.dart';

class RestaurantsListState {
  bool isLoading = false;
  List<RestaurantModel> restaurants;
  String? failedError;

  RestaurantsListState copyWith(
      {bool? isLoading,
      String? failedError,
      List<RestaurantModel>? restaurants}) {
    return RestaurantsListState(
        failedError: failedError ?? this.failedError,
        isLoading: isLoading ?? this.isLoading,
        restaurants: restaurants ?? this.restaurants);
  }

  RestaurantsListState(
      {this.failedError,
      this.isLoading = false,
      List<RestaurantModel>? restaurants})
      : restaurants = restaurants ?? [];
}
