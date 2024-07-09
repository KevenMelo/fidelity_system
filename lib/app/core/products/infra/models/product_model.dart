class ProductModel {
  final int id;
  String name;
  double price;

  ProductModel({required this.id, required this.name, this.price = 0});
  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = 0;
}
