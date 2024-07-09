import 'package:eatagain/app/commons/infra/models/route_model.dart';
import 'package:melo_ui/melo_ui.dart';

class NavItemModel extends MeloUINavItemModel {
  RouteModel root;
  NavItemModel({required super.icon, required super.name, required this.root});
}
