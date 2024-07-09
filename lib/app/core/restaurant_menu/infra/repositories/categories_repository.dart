import 'package:eatagain/app/commons/constants/local_save_keys.dart';
import 'package:eatagain/app/commons/utils/app_utils.dart';
import 'package:eatagain/app/commons/utils/api_client.dart';
import 'package:eatagain/app/core/restaurant_menu/infra/models/category_model.dart';
import 'package:flutter/foundation.dart';

abstract class CategoriesRepository {
  Future<({List<CategoryModel>? data, String? error})> findAll();
  Future<({CategoryModel? data, String? error})> create(CategoryModel category);
  Future<String?> deleteCategory(int id);
}

class CategoriesRepositoryImplementation
    with ApiClient
    implements CategoriesRepository {
  final String _prefix = "restaurants";
  final String _path = "categories";
  CategoriesRepositoryImplementation();

  @override
  Future<String?> deleteCategory(int id) async {
    try {
      String restaurantId =
          await AppUtils.getLocal(LocalSaveKeys.restaurantId) ?? "";
      var response = await delete(
        "$_prefix/$restaurantId/$_path/$id",
      );
      if (response.ok) {
        return null;
      }
      return response.description;
    } catch (e) {
      return kDebugMode ? e.toString() : 'Erro Interno da aplicação';
    }
  }

  @override
  Future<({List<CategoryModel>? data, String? error})> findAll() async {
    try {
      String restaurantId =
          await AppUtils.getLocal(LocalSaveKeys.restaurantId) ?? "";
      var response = await get("$_prefix/$restaurantId/$_path");
      if (response.ok) {
        return (
          data: (response.result as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList(),
          error: null
        );
      }
      return (data: null, error: response.description);
    } catch (e) {
      return (
        data: null,
        error: kDebugMode ? e.toString() : 'Erro Interno da aplicação'
      );
    }
  }

  @override
  Future<({CategoryModel? data, String? error})> create(
      CategoryModel category) async {
    try {
      String restaurantId =
          await AppUtils.getLocal(LocalSaveKeys.restaurantId) ?? "";
      var response = await post<CategoryModel>(
          "$_prefix/$restaurantId/$_path", category.toJson(),
          parser: CategoryModel.fromJson);
      if (response.ok) {
        return (data: response.result, error: null);
      }
      return (data: null, error: response.description);
    } catch (e) {
      return (
        data: null,
        error: kDebugMode ? e.toString() : 'Erro Interno da aplicação'
      );
    }
  }
}
