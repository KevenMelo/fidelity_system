import 'package:eatagain/app/commons/infra/models/response/response_model.dart';
import 'package:eatagain/app/commons/utils/api_client.dart';
import 'package:eatagain/app/commons/utils/app_utils.dart';
import 'package:intl/intl.dart';

class OrdersRepository with ApiClient {
  final String _path = "orders";
  Future<ResponseModel> findAll({required DateTime day}) async {
    String restaurantId = await AppUtils.getLocal("restaurant_id") ?? "";
    var response = await get(
        "restaurants/$restaurantId/$_path?day=${DateFormat('dd/MM/yyyy').format(day)}");
    return response;
  }
}
