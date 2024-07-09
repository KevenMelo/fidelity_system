import 'package:eatagain/app/commons/infra/models/address_model.dart';
import 'package:eatagain/app/core/restaurants/infra/models/restaurant_model.dart';
import 'package:eatagain/app/commons/utils/api_client.dart';

abstract class RestaurantRepository {
  Future<({List<RestaurantModel>? data, String? error})> findAll();
  Future<({RestaurantModel? data, String? error})> findById(String id);
  Future<({RestaurantModel? data, String? error})> create(
      {required String name, required String document, String? phone});
  Future<({RestaurantModel? data, String? error})> updateData(String id,
      {required String name, required String document, String? phone});
  Future<({RestaurantModel? data, String? error})> updateAddress(
      String id, AddressModel address);
  Future<({RestaurantModel? data, String? error})> updateSettingsDistance(
      String id,
      {required int distance,
      required double price,
      required int startIn});
}

class RestaurantRepositoryImplementation
    with ApiClient
    implements RestaurantRepository {
  final String _path = "restaurants";
  RestaurantRepositoryImplementation();

  @override
  Future<({List<RestaurantModel>? data, String? error})> findAll() async {
    try {
      var response = await getList<List<RestaurantModel>>(_path,
          parser: RestaurantModel.toList);
      if (response.ok) {
        return (data: response.result, error: null);
      }
      return (data: null, error: response.description);
    } catch (e) {
      return (data: null, error: 'Erro Interno da aplicação');
    }
  }

  @override
  Future<({RestaurantModel? data, String? error})> findById(String id) async {
    var response = await get("$_path/$id", parser: RestaurantModel.fromJson);
    if (response.ok) {
      return (data: response.result, error: null);
    }
    return (data: null, error: 'Not user');
  }

  @override
  Future<({RestaurantModel? data, String? error})> create(
      {required String name, required String document, String? phone}) async {
    var response = await post(
        _path, {"name": name, "cnpj": document, "phone": phone},
        parser: RestaurantModel.fromJson);

    if (response.ok) {
      return (data: response.result, error: null);
    }
    return (data: null, error: 'Not user');
  }

  @override
  Future<({RestaurantModel? data, String? error})> updateData(String id,
      {required String name, required String document, String? phone}) async {
    var response = await put(
        "$_path/$id", {"name": name, "cnpj": document, "phone": phone},
        parser: RestaurantModel.fromJson);

    if (response.ok) {
      return (data: response.result, error: null);
    }
    return (data: null, error: 'Not user');
  }

  @override
  Future<({RestaurantModel? data, String? error})> updateAddress(
    String id,
    AddressModel address,
  ) async {
    var response = await put("$_path/$id/address", address.toJson(),
        parser: RestaurantModel.fromJson);

    if (response.ok) {
      return (data: response.result, error: null);
    }
    return (data: null, error: response.description);
  }

  @override
  Future<({RestaurantModel? data, String? error})> updateSettingsDistance(
      String id,
      {required int distance,
      required double price,
      required int startIn}) async {
    var response = await put(
        "$_path/$id",
        {
          "distance_delivery": distance,
          "distance_price": price,
          "distance_start": startIn
        },
        parser: RestaurantModel.fromJson);
    if (response.ok) {
      return (data: response.result, error: null);
    }
    return (data: null, error: 'Not user');
  }
}
