import 'package:eatagain/app/commons/constants/local_save_keys.dart';
import 'package:eatagain/app/commons/utils/app_utils.dart';
import 'package:eatagain/app/commons/utils/api_client.dart';
import 'package:eatagain/app/core/payment_methods/infra/extensions/list_payment_method_extension.dart';
import 'package:eatagain/app/core/payment_methods/infra/models/payment_method_model.dart';
import 'package:eatagain/app/core/working_days/infra/models/api/get_working_days_response_model.dart';
import 'package:eatagain/app/core/working_days/infra/models/api/update_working_days_body_model.dart';
import 'package:flutter/foundation.dart';

abstract class PaymentMethodsRepository {
  Future<({List<PaymentMethodModel>? data, String? error})> findAll();
  Future<({List<PaymentMethodModel>? data, String? error})> update(
      List<PaymentMethodModel> methods);
}

class PaymentMethodsRepositoryImplementation
    with ApiClient
    implements PaymentMethodsRepository {
  final String _prefix = "restaurants";
  final String _path = "payments_methods";
  PaymentMethodsRepositoryImplementation();

  @override
  Future<({List<PaymentMethodModel>? data, String? error})> findAll() async {
    try {
      String restaurantId =
          await AppUtils.getLocal(LocalSaveKeys.restaurantId) ?? "";
      var response = await get("$_prefix/$restaurantId/$_path");
      if (response.ok) {
        return (
          data: (response.result as List)
              .map((e) => PaymentMethodModel.fromJson(e))
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
  Future<({List<PaymentMethodModel>? data, String? error})> update(
      List<PaymentMethodModel> methods) async {
    try {
      String restaurantId =
          await AppUtils.getLocal(LocalSaveKeys.restaurantId) ?? "";
      var response =
          await put("$_prefix/$restaurantId/$_path", methods.toJson());
      if (response.ok) {
        return (
          data: (response.result as List)
              .map((e) => PaymentMethodModel.fromJson(e))
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
}
