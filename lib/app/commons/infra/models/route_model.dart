class RouteModel {
  String path;
  String prefix;

  RouteModel({required this.path, required this.prefix});

  String get complete => "$prefix$path";
}
