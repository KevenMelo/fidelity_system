class CategoryComplementModel {
  final int? id;
  String name;

  CategoryComplementModel({this.id, required this.name});

  factory CategoryComplementModel.fromJson(Map<String, dynamic> json) {
    return CategoryComplementModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {"name": name};
}
