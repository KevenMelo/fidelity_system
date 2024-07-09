import 'package:eatagain/app/commons/infra/models/route_model.dart';

class ProductsRoutes {
  static const prefix = '/products';
  static RouteModel root = RouteModel(path: '/', prefix: prefix);
  static RouteModel create = RouteModel(path: '/create', prefix: prefix);
}
