import 'package:eatagain/app/core/restaurant_menu/infra/models/category_complement_model.dart';

class CategoryModel {
  final int? id;
  String name;
  List<CategoryComplementModel> complements;

  CategoryModel(
      {required this.id, required this.name, this.complements = const []});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'],
        name: json['name'],
        complements: (json['complements'] as List)
            .map((e) => CategoryComplementModel.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "complements": complements.map((e) => e.toJson()).toList()
      };
}
