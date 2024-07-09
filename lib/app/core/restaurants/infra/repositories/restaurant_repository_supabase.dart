import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:eatagain/app/core/restaurants/infra/models/restaurant_model.dart';
import 'package:eatagain/app/commons/infra/models/address_model.dart';

import 'restaurant_repository.dart';

class RestaurantRepositorySupabase implements RestaurantRepository {
  final _client = Supabase.instance.client;

  RestaurantRepositorySupabase();

  @override
  Future<({RestaurantModel? data, String? error})> create(
      {required String name, required String document, String? phone}) async {
    try {
      final req = await _client
          .from('restaurants')
          .insert({'name': name, 'cnpj': document, 'phone': phone}).select();

      List<RestaurantModel> restaurant = RestaurantModel.toList(req);
      return (data: restaurant.first, error: null);
    } catch (e) {
      return (data: null, error: e.toString());
    }
  }

  @override
  Future<({RestaurantModel? data, String? error})> findById(String id) async {
    try {
      final req =
          await _client.from('restaurants').select().eq('id', id).select();
      if (req.isEmpty) {
        return (data: null, error: 'Restaurante não encontrado');
      }
      List<RestaurantModel> restaurant = RestaurantModel.toList(req);

      return (data: restaurant.first, error: null);
    } catch (e) {
      return (data: null, error: e.toString());
    }
  }

  @override
  Future<({RestaurantModel? data, String? error})> updateAddress(
      String id, AddressModel address) {
    try {} catch (e) {}
  }

  @override
  Future<({RestaurantModel? data, String? error})> updateData(String id,
      {required String name, required String document, String? phone}) {
    // TODO: implement updateData
    throw UnimplementedError();
  }

  @override
  Future<({RestaurantModel? data, String? error})> updateSettingsDistance(
      String id,
      {required int distance,
      required double price,
      required int startIn}) {
    // TODO: implement updateSettingsDistance
    throw UnimplementedError();
  }

  @override
  Future<({List<RestaurantModel>? data, String? error})> findAll() async {
    final req =
        await _client.from('restaurants').select().eq('id', id).select();
  }
}
