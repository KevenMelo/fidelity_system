class OrderModel {
  final int id;
  String name;
  String customer;
  String address;
  double price;
  String status;

  OrderModel(
      {required this.id,
      required this.name,
      this.customer = "",
      this.address = "",
      this.price = 0,
      this.status = ""});
  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        customer = "",
        address = "",
        price = 0,
        status = "";
}
