import 'package:eatagain/app/core/payment_methods/infra/models/payment_method_model.dart';

extension ListPaymentMethodExtension on List<PaymentMethodModel> {
  Map<String, dynamic> toJson() =>
      {"payments_methods": map((e) => e.toJson()).toList()};
}
