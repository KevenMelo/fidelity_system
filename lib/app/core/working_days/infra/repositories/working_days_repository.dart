import 'dart:convert';

import 'package:eatagain/app/commons/constants/local_save_keys.dart';
import 'package:eatagain/app/commons/utils/app_utils.dart';
import 'package:eatagain/app/commons/utils/api_client.dart';
import 'package:eatagain/app/core/working_days/infra/models/api/get_working_days_response_model.dart';
import 'package:eatagain/app/core/working_days/infra/models/api/update_working_days_body_model.dart';
import 'package:eatagain/app/core/working_days/infra/models/working_day_model.dart';
import 'package:flutter/foundation.dart';

abstract class WorkingDaysRepository {
  Future<({GetWorkingDaysResponseModel? data, String? error})> findAll();
  Future<({GetWorkingDaysResponseModel? data, String? error})> update(
      UpdateWorkingDaysBodyModel body);
}

class WorkingDaysRepositoryImplementation
    with ApiClient
    implements WorkingDaysRepository {
  final String _prefix = "restaurants";
  final String _path = "workings_days";
  WorkingDaysRepositoryImplementation();

  @override
  Future<({GetWorkingDaysResponseModel? data, String? error})> findAll() async {
    try {
      String restaurantId =
          await AppUtils.getLocal(LocalSaveKeys.restaurantId) ?? "";
      var response = await get<GetWorkingDaysResponseModel>(
          "$_prefix/$restaurantId/$_path",
          parser: GetWorkingDaysResponseModel.fromJson);
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

  @override
  Future<({GetWorkingDaysResponseModel? data, String? error})> update(
      UpdateWorkingDaysBodyModel body) async {
    try {
      String restaurantId =
          await AppUtils.getLocal(LocalSaveKeys.restaurantId) ?? "";
      var response = await put<GetWorkingDaysResponseModel>(
          "$_prefix/$restaurantId/$_path", body.toJson(),
          parser: GetWorkingDaysResponseModel.fromJson);
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
