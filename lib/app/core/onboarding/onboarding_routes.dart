import 'package:eatagain/app/commons/infra/models/route_model.dart';

class OnboardingRoutes {
  static const prefix = '/onboarding';
  static RouteModel root = RouteModel(path: '/', prefix: prefix);
  static RouteModel address = RouteModel(path: '/address', prefix: prefix);
  static RouteModel confirmAddress =
      RouteModel(path: '/address/confirm', prefix: prefix);

  static RouteModel delivery = RouteModel(path: '/delivery', prefix: prefix);
}
