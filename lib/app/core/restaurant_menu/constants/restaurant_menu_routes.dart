import 'package:eatagain/app/commons/infra/models/route_model.dart';

class RestaurantMenuRoutes {
  static const prefix = '/restaurant-menu';
  static RouteModel root = RouteModel(path: '/', prefix: prefix);
  static RouteModel categoriesList = RouteModel(path: '/', prefix: prefix);
  static RouteModel categoriesForm =
      RouteModel(path: '/categories/create', prefix: prefix);
}
