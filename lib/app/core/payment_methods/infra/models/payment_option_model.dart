class PaymentOptionModel {
  int id;
  int methodId;
  String name;
  String photo;
  bool isActive;
  double tax;
  bool isPercentTax;

  PaymentOptionModel(
      {required this.id,
      required this.methodId,
      required this.name,
      required this.photo,
      required this.isActive,
      required this.tax,
      required this.isPercentTax});

  factory PaymentOptionModel.fromJson(Map<String, dynamic> json) =>
      PaymentOptionModel(
          id: json['id'],
          methodId: json['method_id'],
          name: json['name'],
          photo: json['photo'],
          tax: json['tax'].toDouble(),
          isActive:
              json['active'] is bool ? json['active'] : json['active'] == 1,
          isPercentTax:
              json['percent'] is bool ? json['percent'] : json['percent'] == 1);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "tax": tax,
        "active": isActive,
        "percent": isPercentTax,
      };
}
