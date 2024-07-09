import 'package:eatagain/app/core/payment_methods/infra/enums/payment_method_type.dart';
import 'package:eatagain/app/core/payment_methods/infra/models/payment_option_model.dart';

class PaymentMethodModel {
  int id;
  String name;
  PaymentMethodType type;
  List<PaymentOptionModel> options;

  PaymentMethodModel(
      {required this.id,
      required this.type,
      required this.name,
      required this.options});

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        id: json['id'],
        name: json['name'],
        type: PaymentMethodType.fromName(json['name']),
        options: (json['options'] as List)
            .map((e) => PaymentOptionModel.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "options": options.map((e) => e.toJson()).toList()
      };
}
